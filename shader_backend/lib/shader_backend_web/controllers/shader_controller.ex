defmodule ShaderBackendWeb.ShaderController do
  use ShaderBackendWeb, :controller
  alias ShaderBackend.LLMService

  def create(conn, params) do
    description = Map.get(params, "description")

    case LLMService.generate_shader_code(description) do
      {:ok, shader_code} ->
        json(conn, %{ok: true, shader_code: shader_code})

      {:error, reason} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{ok: false, error: reason})
    end
  end
end