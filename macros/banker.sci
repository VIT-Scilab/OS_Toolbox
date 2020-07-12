function [Available] = banker(Alloc,Max,Available,p,r)
    counter=0// Number of currently executing Processes
    for i=1:p // Loop through all the processes
        running(i)=1; //Executing Processes in the system
        counter = counter+1; // Incrementing the count of executing processes
    end // End Loop
    Need = Max - Alloc // Number of instances of each resource type still required for completing the execution of process
    while counter~=0 // Loop until no process is still under execution
        safe = 0 // Safe state indicating that the process has completed execution and has finished its work
        for i=1:p // Loop through all the processes
            if running(i) then // If any process is executing
                execute=1; // Set the execute variable to 1 
                for j=1:r // Looping through the resources
                    if Need(i,j) > Available(j) then // If the need of the process is greater than the available resources in the system
                       execute = 0; // Set the execute variable to 0
                       break; 
                    end // End If
                end // End For
                if execute then // If the execute varaiable is true or 1 (i.e) the need of the executing process is less than or equal to available resources in the system 
                    mprintf("\nProcess%d is executing\n",i) // Display the Executing Process
                    running(i)=0; // Set the execution of the process to 0 after completion of execution
                    counter = counter - 1; // Decrement the number of currently executing processes on completion of process
                    safe = 1; // Set the safe variable to 1 or true (i.e) Indicates process has completed its execution without any deadlock 
                    for j=1:r // Loop through  the resources
                        Available(j) = Available(j) + Alloc(i,j); // On Completion of process release the allocated resources back to the system for future use by other processes
                    end // End for
                    break;
                end // End If
                end //End If
        end //End for
        if ~safe then // If any process has not completed its execution
            mprintf("\n Remaining Processes are in Unsafe State\n") // There is Deadlock and the process is in unsafe state
            break;
        else
            mprintf("\n Process is in Safe State") // Process is in safe state and there is no deadlock
            mprintf("\n Available Vector:") // Available resources in the system
            for i=1:r // Loop through the resources
                mprintf("\t%d",Available(i))// Display the Available resources in the system after completion of each process
            end // End for
            mprintf("\n") // Print each available resources in separate line after completion of execution of process
        end // End if 
    end // End While
    if counter == 0 then
        mprintf("\n System is in Safe State\n")
    else
        mprintf("\n System is in Unsafe State \n")
    end
    endfunction
