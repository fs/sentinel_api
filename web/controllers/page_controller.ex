defmodule SentinelApi.PageController do
  use SentinelApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
