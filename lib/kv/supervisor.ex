defmodule KV.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @manager_name KV.EventManager
  @registry_name KV.Registry
  @bucket_sup_name

  def init(:ok) do
    children = [
      worker(GenEvent, [[name: @manager_name]]),
      supervisor(KV.Bucket.Supervisor, [[name: @bucket_sup_name]]),
      worker(KV.Registry, [:table, @manager_name, [name: @registry_name]])
    ]
    
    supervise(children, strategy: :one_for_one)
  end
end
