defmodule Plug.Parsers.COPIEDBODYJSON do
  @moduledoc """
  Parses JSON request body from copied body in conn.
  JSON arrays are parsed into a `"_json"` key to allow
  proper param merging.
  An empty request body is parsed as an empty map.
  """

  @behaviour Plug.Parsers
  import Plug.Conn

  require Logger

  def parse(conn, "application", subtype, _headers, opts) do
    if subtype == "json" || String.ends_with?(subtype, "+json") do
      decoder = Keyword.get(opts, :json_decoder) ||
                  raise ArgumentError, "JSON parser expects a :json_decoder option"
      conn
      |> read_body
      |> decode(decoder)
    else
      {:next, conn}
    end
  end

  def parse(conn, _type, _subtype, _headers, _opts) do
    {:next, conn}
  end

  defp decode({:more, _, conn}, _decoder) do
    {:error, :too_large, conn}
  end

  defp decode({:error, :timeout}, _decoder) do
    raise Plug.TimeoutError
  end

  defp decode({:error, _}, _decoder) do
    raise Plug.BadRequestError
  end

  defp decode({:ok, "", conn}, _decoder) do
    {:ok, %{}, conn}
  end

  defp decode({:ok, body, conn}, decoder) do
    case decoder.decode!(body) do
      terms when is_map(terms) ->
        {:ok, terms, copy_body(conn, body)}
      terms ->
        {:ok, %{"_json" => terms}, copy_body(conn, body)}
    end
  rescue
    e -> raise Plug.Parsers.ParseError, exception: e
  end

  defp copy_body(conn, body) do
    conn
    |> put_private(:copied_body, body)
  end
end
