defmodule Duper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, {root, number_of_workers}) do
    children = [
      Duper.Results,
      { Duper.PathFinder, root },
      Duper.WorkerSupervisor,
      { Duper.Gatherer, number_of_workers }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_all, name: Duper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
