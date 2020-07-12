function [tat,pid]=npriority(n,priority,at,bt,p)
    time=0
    waiting=[]
    response=[]
    tat=[]
    pid=[]
    if ~exists("p","local") then
    p = 0
     end
for i=1:n
 st(i)=struct('priority',priority(i),'at',at(i),'bt',bt(i),'pid',i);
end
//Sorting based on priority
for i=1:n
    for j=i+1:n
        if st(i).priority>st(j).priority
            temp=st(i);
            st(i)=st(j);
            st(j)=temp;
        end     
    end
end
for i= 1:n
    pid(i)=st(i).pid
end
if p==1 then
    mprintf("Gantt chart:\n")
for i=1:n
    
    mprintf("P%d  ",st(i).pid)
end
end
time=st(1).at+st(1).bt
if p==1 then
    mprintf("\npid\t Priority\t Arrival_time\t Burst_time  Completion_time  Turnaround_time  Waiting_time Response_time\n")
end

waiting(1)=time-st(1).at-st(1).bt;
tat(1)=time-st(1).at;
response(1)=waiting(1)+st(1).at;

if p==1 then
    mprintf("P%d\t  %d\t\t\t %d\t\t %d\t\t%d\t\t%d\t\t%d\t%d\n",...
    st(1).pid,st(1).priority,st(1).at,st(1).bt,time,tat(1),waiting(1),response(1));
end

for i=2:n
  if time>=st(i).at then
      time=time+st(i).bt
else
    time_rem=st(i).at-time
    time=time+time_rem+st(i).bt  
end
waiting(i)=time-st(i).at-st(i).bt;
tat(i)=time-st(i).at;
response(i)=waiting(i)+st(i).at;
if p==1 then
mprintf("P%d\t  %d\t\t\t %d\t\t %d\t\t%d\t\t%d\t\t%d\t%d\n",...
        st(i).pid,st(i).priority,st(i).at,st(i).bt,time,tat(i),waiting(i),response(i));
end
end
w=0;tt=0;r=0;
for i=1:n
    w=w+waiting(i)
    tt=tt+tat(i)
    r=r+response(i)
end
if p==1 then
    mprintf("\nAverage Waiting time:%.2f\nAverage Turnaround time:%.2f\n",w/n,tt/n);
    mprintf("Average Response time:%.2f",r/n);
end
endfunction
