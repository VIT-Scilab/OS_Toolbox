/*****************************************************************************
Copyright © 2020 

Authors: Surya Prasad S, Yeshwanth R, Tharun Bhargav A, Aravind Krishna R, Dr. Maheswari R
Organization: VIT Chennai
Email: suryavirat09@gmail.com, yeshwa.rp@gmail.com, tharun.cam@gmail.com, aravind2000krishna@gmail, maheswari.r@vit.ac.in 

This file must be used under the terms of CeCILL. This source file is licensed as described in the file LICENSE, 
which you should have received as part of this distribution.  The terms are also available at
https://cecill.info/licences/Licence_CeCILL_V2-en.txt 

This software is governed by the CeCILL  license under French law and
abiding by the rules of distribution of free software.  You can  use, 
modify and/ or redistribute the software under the terms of the CeCILL
license as circulated by CEA, CNRS and INRIA at the following URL
"http://www.cecill.info". 

As a counterpart to the access to the source code and  rights to copy,
modify and redistribute granted by the license, users are provided only
with a limited warranty  and the software's author,  the holder of the
economic rights,  and the successive licensors  have only  limited
liability. 

In this respect, the user's attention is drawn to the risks associated
with loading,  using,  modifying and/or developing or reproducing the
software by the user in light of its specific status of free software,
that may mean  that it is complicated to manipulate,  and  that  also
therefore means  that it is reserved for developers  and  experienced
professionals having in-depth computer knowledge. Users are therefore
encouraged to load and test the software's suitability as regards their
requirements in conditions enabling the security of their systems and/or 
data to be ensured and,  more generally, to use and operate it in the 
same conditions as regards security. 

The fact that you are presently reading this means that you have had
knowledge of the CeCILL license and that you accept its terms.
**********************************************************************************/
function [ret,Available] = banker(Alloc,Max,Available,p,r,pr)
    if ~exists("pr","local") then
        pr = 0
    end
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
                    if pr==1 then
                    mprintf("\nProcess%d is executing\n",i) // Display the Executing Process
                    end
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
            if pr==1 then
            mprintf("\n Remaining Processes are in Unsafe State\n") // There is Deadlock and the process is in unsafe state
        end  
            break;
        else
            if pr==1 then
            mprintf("\n Process is in Safe State") // Process is in safe state and there is no deadlock
            mprintf("\n Available Vector:") // Available resources in the system
            end
            for i=1:r // Loop through the resources
                if pr==1
                mprintf("\t%d",Available(i))// Display the Available resources in the system after completion of each process
            end // End for
            mprintf("\n") // Print each available resources in separate line after completion of execution of process
        end // End if 
        end
    end // End While
    if counter == 0 then
        if pr==1 then
        mprintf("\n System is in Safe State\n")
        end
    ret=1
else
    if pr==1 then
        mprintf("\n System is in Unsafe State \n")
    end
    ret=0
    end
    endfunction
