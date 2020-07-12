function [tatime]=fcfs(num,btime,p)  // Function defintion of first come first serve 
if ~exists("p","local") then
        p = 0
end
t1=0;               // intializing time t1=0 for total waiting time calculation
t2=0;              // intializing time t2=0 for total turn round time calculation

btime         // assigning burst time 
wtime=zeros(1,num)        // assigning waiting time
tatime=zeros(1,num)      // assigning turn around time
n=num;              // assigning number of process n=4 here
fd = %io(2);

 //For loop for calculating total waiting time of each Process 
    for i=2:1:n
     wtime(i)=btime(i-1)+wtime(i-1);  //waiting time will be sum of burst time of previous process and waiting time of previous process
     t1=t1+wtime(i);                  //calculating total waiting time
    end 

//For loop for calculating total turn around time of each Process 
    for i=1:1:n
     tatime(i)=btime(i)+wtime(i);     //turn around time=burst time +wait time
     t2=t2+tatime(i);                 //total turn around time
    end    
    
   
    //displaying the waiting time of each Process 
    if p==1 then
        for i=1:1:n
         mfprintf(fd,'   P%d is %d',i,wtime(i));  
        end 
    disp('Turn-Around Time of each Process');       //displaying the final Turn-Around time of each Process
    for i=1:1:n
        mfprintf(fd,'   P%d is %d',i,tatime(i));
    end
    
    mfprintf(fd,'\n   Average Waiting Time is  %.2f',t1/n);       //displaying the Average waiting time 
    mfprintf(fd,'\n   Average Turn-Around Time  is %.2f',t2/n);   //displaying the Average Turn Around time  
end
endfunction     
