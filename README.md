# Computing-Vampire-Numbers
Objective of the project is to use Elixir with the actor model to print the vampire numbers and its fangs within the provided range as input.

Vampire numbers are composite natural numbers having even number of digits that can be factored into two natural numbers having exactly 
half of number of digits as the original number. These factors are called fangs. Both the fangs can not have trailing zeros at the same time. 
Both the fangs contain precisly all the digits of original number, in any order, counting multiplicity. Example: 2187 has fangs 27 and 81.


Steps to run the program:  
  1) Change the directory as the root of the project with the proj1.exs file
  2) Run the following command:
     mix run proj1.exs arg1 arg2
     arg1 and arg2 being the input arguments

2. The number of workers in the code is kept to 5 as we thought the optimal number of workers that would be appropriate would be around 5.

3. The input range would be chunked equally to the number of workers. Each worker would work on the chunk of the input range. 
The size of the work unit in our case would be the total input range divided into 5 chunks.


Running time for the input 100000 200000 is: 
real 0m4.102s
user 0m16.338s
sys 0m0.295s

The CPU time to REAL time ratio for the above input is 4.06

 The largest input provided was: 1 to 1000000
  The largest vampire number in this range is 939658 whose fangs are 953 986 
