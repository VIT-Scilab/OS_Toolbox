//WINDOWS 10 64-BIT OS , Scilab and toolbox versions 6.1.0.

clc;
//Display Function:It prints all required details such as Process no. 
//Waiting time, Turn-Around time, Average Waiting time and Average Turn-Around time

function display(size_process,wtime,tatime,avg,avg1)
             //display of final values


disp('Waiting time of each Process using SFJ'); //displaying the Waiting time
for i=1:1:n
    mfprintf(fd,'    is %d',wtime(i)); 
end

disp('Turn-Around time of each Process using SFJ'); //displaying the Turn-Around time
for i=1:1:n
    mfprintf(fd,'    is %d',tatime(i));
end

mfprintf(fd,'\n   Average Waiting Time using SJF is %.2f',avg);   //displaying the Average Waiting time
mfprintf(fd,'\n   Average Turn-Around Time using SFJ is %.2f',avg1);  //displaying the Average Turn-Around time

endfunction
