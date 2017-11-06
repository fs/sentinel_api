defmodule SentinelApi.Prediction do
  @success_regex = ~r/Predict (?<name>\w+) with (?<conf>\d\.\d\d) confidence/
  @failure_regex = ~r/Unable to find a face/

  def learn do
    case start_learning do
      _ -> "Classificator is ready"
    end
  end

  def predict do
    p = start_prediction

    case Regex.named_captures(@success_regex, p) do
      nil ->
        case Regex.named_captures(@failure_regex, p) do
          nil -> "no result"
          _ -> "Face was not found on picture"
        end
      %{"conf" => conf, "name" => name} -> "Predicted: #{name}. Confidence: #{conf}"
    end
  end

  defp start_learning do
    System.cmd(
      "#{priv_dir}/learn",
      ["4", "/home/deploy/openface", "#{common_dir}/uploads"],
      stderr_to_stdout: true
    )
  end

  defp start_prediction do
    System.cmd(
      "#{priv_dir}/predict",
      ["/home/deploy/openface", "#{common_dir}/uploads"],
      stderr_to_stdout: true
    )
  end

  defp app_dir do
    Application.app_dir(:sentinel_api)
  end

  defp priv_dir do
    Application.app_dir(:sentinel_api, "priv")
  end

  defp common_dir do
    "/home/deploy/sentinel_api"
  end

  defp callback(uri, result) do
    # HTTPoison.get("#{uri}&data=#{result}")
    HTTPoison.post(
      uri,
      {
        :form,
        [ {:data, result} ]
      }
    )
  end
end
