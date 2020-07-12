// Function to sort the processes in the order of arrival time
function [] = sort_processes(pro,at,bt,n)
    for i=2:n
        j=i-1;
        key1 = pro(i);
        key2 = at(i);
        key3 = bt(i);
        while j>=1 && key2 < at(j)
            at(j+1) = at(j);
            bt(j+1) = bt(j);
            pro(j+1) = pro(j);
            j = j-1;
        end
           pro(j+1) = key1;
           at(j+1) = key2;
           bt(j+1) = key3;
    end
endfunction

function [sum_turnaround,sum_wait] = rr(at,bt,n,time_quantum)
    sum_turnaround = 0;
sum_wait = 0;
t = 0;
    for i=1:n
        pro(i) = i;
    end
    sort_processes(pro,at,bt,n)
    for i=1:n
        rt(i) = bt(i);
    end
    sum_wait = at(1);
    mprintf("\n\nProcess     Arrival Time      Burst Time      Completion Time      Turnaround Time     Waiting Time\n")
        // Preemption Of processes and calculate completion time
        temp = n;
        time = 0;
        while temp ~= 0
            for i=1:n
                if (rt(i) <= time_quantum && rt(i) > 0) then 
                time = time + rt(i);
                rt(i) = 0;
                t = 1;
                end
                if rt(i) > 0 then
                    rt(i) =rt(i) - time_quantum;
                    time = time_quantum + time
                end
            if rt(i) == 0 && t == 1 then
                temp = temp -1;
                mprintf("P%d\t\t%d\t\t%d\t\t%d\t\t%d\t\t\t%d\n",pro(i),at(i),bt(i),time,time-at(i),time-at(i)-bt(i))
                // Calculate Average Wait and Turnaround Time
                sum_wait  = sum_wait + time -at(i) -bt(i);
                sum_turnaround  = sum_turnaround + time -at(i);
                t=0;
            end
            // Round Robin coming back to the left over processes
            if i == n-1 then 
                i = 1;
            end
            if at(i) <= time then
                i = i+1;
            else
                i = 1;
            end
        end
    end
 mprintf("\nAvg Waiting Time = %f\n",sum_wait*1.0/n)
 mprintf("Avg Turn Around Time = %f",sum_turnaround*1.0/n)
endfunction       
