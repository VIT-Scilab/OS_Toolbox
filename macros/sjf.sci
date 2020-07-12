//WINDOWS 10 64-BIT OS , Scilab and toolbox versions 6.1.0.
function [tatime]=sjf(num,pt,p)  // Function defintion of first come first serve 
   if ~exists("p","local") then
        p = 0
   end
n=num     // number of processes
ptime = pt  //process time or burst time
tatime =zeros(1,num)  //turn around time
wtime = zeros(1,num)   //waiting time
fd = %io(2);
total=0;
total2=0;
//Determining the number of processes and blocks
size_process = n;
size_ptime = size(ptime);
size_ptime = size_ptime(2);

//marks the position of process with minimum burst time in the specified range. This may be used to rearrange the order of the processes to achieve proper SJF scheduling...
for i=1:1:n-1   //For loop for sorting the processes in terms of process times
   for j=i+1:1:n
       if(ptime(i)>ptime(j))
           temp=ptime(i);           //temporary variable used to enable efficient swapping of values ..
           ptime(i) = ptime(j);
           ptime(j) = temp;
       end
  end
   
end

 wtime(1) = 0;
 //waiting time calculation
 for i=2:1:n
    wtime(i) = wtime(i-1)+ptime(i-1);   //wait time of a process is sum of wait time of process before it and process time of process before it
    total = total + wtime(i);           //finding total waiting time
end

//total turnaround time calculation
for i=1:1:n
    tatime(i)=ptime(i)+wtime(i);    //turn around time=burst time +wait time
    total2=total2+tatime(i);                //total turn around time
end

avg = total/n;                          //finding average time, average waiting time calculated by dividing total waiting time by number of proceses
avg1 = total2/n;                        //average turn around time calculated by dividing total turn around time by number of processes
if p==1 then
    display(size_process,wtime,tatime,avg,avg1) //displaying the process and block allocation by first fit array
    end      

endfunction
