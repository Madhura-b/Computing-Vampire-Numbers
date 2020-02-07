defmodule VampireNumber do
  use GenServer

  @spec start_link(integer, integer) :: {:ok, pid}
  def start_link(num1,num2) do
      num = Enum.to_list(num1..num2)
      {:ok,pid} = GenServer.start_link(VampireNumber,num)
      compute_vamp(pid,num)
      {:ok,pid}
  end
def compute_vamp(process_id,num) do
    GenServer.cast(process_id,{:vamp_num,num})
end

def handle_cast({:vamp_num,num},_state) do
  first = Enum.at(num,0)
  last = Enum.at(num,length(num)-1)
  result = Enum.filter( Enum.map(first..last, fn x -> is_vampnumber(x) end), & &1)
  {:noreply,result}
end

def read_vamp(pid) do
  GenServer.call(pid, :get_vmps, :infinity)
end

def handle_call(:get_vmps, _from, state) do
  {:reply, state, state}
end

def vampire_range(range) do
  resultset=for i <- range, do: is_vampnumber(i)
  outresult = Enum.filter(resultset,& &1)
  is_binary(outresult)
end
  def init(limit) do
    {:ok,limit}
   end


  def same_characters(string1,string2) do
    string1_charlist = String.codepoints(string1)
    string2_charlist = String.codepoints(string2)
    sorted_string1 = Enum.sort(string1_charlist)
    sorted_string2 = Enum.sort(string2_charlist)
    cond do
      sorted_string1 == sorted_string2 -> true
      true -> false
    end
  end

  def is_vampnumber(number) do
    number_string = Integer.to_string(number)
    n =trunc(:math.sqrt(number))
    half_len = String.length(number_string)/2
    #result_list=[]
    result = for i <- 2..n, String.length(Integer.to_string(i)) == half_len &&
          rem(number,i)==0,do:
    (
          factor1 = i
          factor2 = trunc(number/i)
          if String.length(Integer.to_string(factor2)) == half_len, do:
          (
            f1 =Integer.to_string(factor1)
            f2 = Integer.to_string(factor2)
            factors = f1 <> f2
            if same_characters(number_string,factors),
          do: " #{f1} #{f2}"
          )
    )
    output =  Enum.filter(result, & &1)
    if output != [], do: number_string  <> Enum.join(output, " ")
  end
end


 defmodule Parent2 do
   use Supervisor

   def start_link(first,last) do
      Supervisor.start_link(__MODULE__, [first,last])
   end

   def init([first,last]) do
    list = Enum.to_list(first..last)
    count = ceil((length(list))/5)

    rs = Enum.chunk_every(list, count,count)

    children = Enum.map(rs, fn x -> worker(VampireNumber, [List.first(x),List.last(x)], [id: List.first(x), restart: :temporary]) end)
    supervise(children, strategy: :one_for_one)

   end
 end





