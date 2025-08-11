defmodule ShaderBackendWeb.PageController do
  use ShaderBackendWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
