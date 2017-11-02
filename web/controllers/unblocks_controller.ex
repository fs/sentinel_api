defmodule SentinelApi.UnblocksController do
  use SentinelApi.Web, :controller

  alias SentinelApi.ImageClassification

  def create(conn, %{"unblock" => unblock_params}) do
    case ImageClassification.start(unblock_params) do
      {:ok, result} ->
        conn
        |> put_status(:created)
        |> json %{data: result}
      {:error, message} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json %{data: %{error: message}}
    end
  end
end
