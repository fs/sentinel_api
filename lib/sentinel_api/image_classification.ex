defmodule SentinelApi.ImageClassification do
  alias SentinelApi.Image
  alias SentinelApi.Prediction

  def start(%{"image" => image, "callback_uri" => callback_uri, "name" => name}) do
    case name do
      "_" ->
        case Image.store({image, "test"}) do
          {:ok, filename} ->
            result = elem(start_prediction, 0)
            IO.puts(result)

            callback(callback_uri, result)
            {:ok, %{predict: result}}
          {:error, reason} ->
            IO.puts(reason)

            {:error, reason}
        end
      _ ->
        case Image.store({image, name}) do
          {:ok, filename} ->
            IO.puts(filename)

            start_learning
            {:ok, %{file: filename}}
          {:error, reason} ->
            IO.puts(reason)

            {:error, reason}
        end
    end
  end
end
