#!/bin/bash


# Greeting the users according to the time
time_greet=$(date +%H)

#echo $time
if (( time_greet >= 0 && time_greet <= 11 )); then
	echo "Good Morning!"
elif (( time_greet >= 12 && time_greet <= 15 )); then
	echo "Good AfterNoon!"
else
	echo "Good Evening!"

fi

# Introduction	
echo "Welcome to Real-Time Clock Manager"
sleep 1
echo "How we may help you today?"
sleep 1



# SETTING ALARM
function set_alarm(){
while :; do
	echo
	echo "1. To set Alarm."
	echo "2. Exit."
	
	read -p "Enter your choice [1-2]: " choice1
	
	if [ $choice1 == 1 ]; then
		while :; do
			read -p "When to set alarm? (format-> 14:30 or 2:30PM): " alarm_time
			text="Default Message: Time to wake up!"
			echo $text
			read -p "Do you want to change the text? [Y/n]" ch
			if [ $ch == "Y" ]; then
				echo "To have message longer, separate the words with '_'"
				read -rp "Enter your text: " user_text
				
				echo zenity --info --title="Alarm" --text=$user_text --no-wrap | at $alarm_time
				echo 'play /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga' | at $alarm_time
								
				
			elif [ $ch == "n" ] || [ $ch == "N" ]; then
				echo "Continuing with the Default one."
				echo 'notify-send -u critical -t 0 "Time to wake up" & play /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga' | at $alarm_time
			
			else 
				echo "Invalid Choice."
				continue
			fi
		
			break
		done
	
	elif [ $choice1 == 2 ]; then
		echo "Exiting the Alarm Section!"
		break
	
	else 
		echo "Invalid Choice! Choose from [1-2]"
	
	fi
done		
	
}




# WRITING DIARY
function diary(){
	echo 
	echo "Welcome to 'My Notes' section."
	save_directory="daily_notes"

	# if it doesn't exist
	mkdir -p "$save_directory"


	while :; do
		echo "1. Write a new Diary."
		echo "2. Read old ones."
		echo "3. Edit and Save."
		echo "4. Diary Deletion."
		echo "5. Exit."
		
		read -p "Enter you Choice: " choice2
		
		if [ $choice2 == 1 ]; then
			current_datetime=$(date +"%b-%d-%Y_%H:%M:%S")

			echo "Enter your daily notes. Press Enter and then Ctrl+D to save and exit."
			user_input=$(cat)

			file_name="$save_directory/${current_datetime}.txt"

			echo "$user_input" > "$file_name"
			echo "Notes saved to: $file_name"
		
		
		elif [ $choice2 == 2 ]; then
			echo "::Reminiscing Memories::"	
				
			while :; do
				read -p "Enter the Month of which diary you want to read (or type 'q' to exit): " s_mon
				if [ $s_mon == 'q' ]; then
					break
				elif [ $s_mon == 'Jan' ] || [ $s_mon == 'Feb' ] || [ $s_mon == 'Mar' ] || [ $s_mon == 'Apr' ] || [ $s_mon == 'May' ] || [ $s_mon == 'Jun' ] || [ $s_mon == 'Jul' ] || [ $s_mon == 'Aug' ] || [ $s_mon == 'Sep' ] || [ $s_mon == 'Oct' ] || [ $s_mon == 'Nov' ] || [ $s_mon == 'Dec' ]; then					
					ls $save_directory | grep "$s_mon"
					read -p "Enter the file name you want to read: " d_file
					cat $save_directory/$d_file
					break
				else 
					echo "Invalid."
					echo "Write the month in three letter format. Example: Jan or Dec."
					continue
				fi
			done
			
		
		elif [ $choice2 == 3 ]; then
			echo "::Editing and saving::"
			
			while :; do
				read -p "Enter the Month of which diary you want to read (or type 'q' to exit): " s_mon
				if [ $s_mon == 'q' ]; then
					break
				elif [ $s_mon == 'Jan' ] || [ $s_mon == 'Feb' ] || [ $s_mon == 'Mar' ] || [ $s_mon == 'Apr' ] || [ $s_mon == 'May' ] || [ $s_mon == 'Jun' ] || [ $s_mon == 'Jul' ] || [ $s_mon == 'Aug' ] || [ $s_mon == 'Sep' ] || [ $s_mon == 'Oct' ] || [ $s_mon == 'Nov' ] || [ $s_mon == 'Dec' ]; then 					
					ls $save_directory | grep "$s_mon"
					read -p "Enter the file name you want to edit: " d_file
					
					echo "After Editing, Press (Shift+S) to Save and (Shift+X) to Exit -> "
					sleep 2
					nano $save_directory/$d_file 
					
					echo "The changes have been made."
					sleep 2
					cat $save_directory/$d_file
					
					echo
					break
				else 
					echo "Invalid."
					echo "Write the month in three letter format. Example: Jan or Dec."
					continue
				fi
			done  
		
		elif [ $choice2 == 4 ]; then
			echo
			echo "Deleting Memories"
			
			while :; do
			
				echo "1. To delete a particular diary."
				echo "2. To delete an album (By month)."
				echo "3. Exit"
				
				read -p "Enter your choice: " ch2

				
				if [ $ch2 == 1 ]; then
					while :; do
						read -p "Enter the Month (or type 'q' to exit): " s_mon
						if [ $s_mon == 'q' ]; then
							break
						elif [ $s_mon == 'Jan' ] || [ $s_mon == 'Feb' ] || [ $s_mon == 'Mar' ] || [ $s_mon == 'Apr' ] || [ $s_mon == 'May' ] || [ $s_mon == 'Jun' ] || [ $s_mon == 'Jul' ] || [ $s_mon == 'Aug' ] || [ $s_mon == 'Sep' ] || [ $s_mon == 'Oct' ] || [ $s_mon == 'Nov' ] || [ $s_mon == 'Dec' ]; then	 					
							ls $save_directory | grep "$s_mon"
							read -p "Enter the file name you want to delete: " d_file
							rm $save_directory/$d_file 
							
							echo "The diary has been deleted."
							sleep 2						
							echo
							break
						else
							echo "Invalid."
							echo "Write the month in three letter format. Example: Jan or Dec."
							continue
						fi
					done
				elif [ $ch2 == 2 ]; then
					cd $save_directory
					
					while :; do
						read -p "Enter the Month (or type 'q' to exit): " s_mon
						if [ $s_mon == 'q' ]; then
							break
						elif [ $s_mon == 'Jan' ] || [ $s_mon == 'Feb' ] || [ $s_mon == 'Mar' ] || [ $s_mon == 'Apr' ] || [ $s_mon == 'May' ] || [ $s_mon == 'Jun' ] || [ $s_mon == 'Jul' ] || [ $s_mon == 'Aug' ] || [ $s_mon == 'Sep' ] || [ $s_mon == 'Oct' ] || [ $s_mon == 'Nov' ] || [ $s_mon == 'Dec' ]; then				
							ls ~/CP/$save_directory | grep "$s_mon" | xargs rm -fr
							
							echo "The album has been deleted."
							sleep 2						
							echo
							break
						else 
							echo "Invalid."
							echo "Write the month in three letter format. Example: Jan or Dec."
							continue
						fi
					done
					
					cd ..
					
				
				elif [ $ch2 == 3 ]; then
					break
				
				else
					echo "Invalid Choice. Choose from [1-3]."
				fi
			
			done
				
		elif [ $choice2 == 5 ]; then
			echo "Exiting the Diary Section."
			break
				
		else
			echo "Invalid Choice! Choose from [1-4]."
			
		fi
	done
	
}



# Notification function

notified(){

file=$1
while IFS= read -r line || [[ -n "$line" ]]; do
# Extract message and time from each line
message2=$(echo "$line" | awk '{print $1}')
time2=$(echo "$line" | awk '{print $2}')
#notify-send $message2 | at $time			
echo notify-send -u critical -t 0 "$message2" | at $time2
done < "$file"

}



#SETTING REMINDERS
function set_reminders(){

# making a new file
reminder_dir="Reminders"
mkdir -p "$reminder_dir"
current_datetime1=$(date +"%d-%b-%Y")
file_name1="$reminder_dir/${current_datetime1}.txt"

while :; do
	echo "1. Make new Reminder (once)."
	echo "2. To make a Schedule."
	echo "3. Editing the schedule."
	echo "4. Exit."
	
	read -p "Enter your Choice [1-4]: " choice3
	
	if [ $choice3 == 1 ]; then
		# message that you want to be reminded at a certain time
		echo "Enter your message: "
		read message1
		echo "At what time you want to be notified (format: 4:00PM or 9:30AM): "
		read time1
		
		echo notify-send -u critical -t 0 "$message1" | at $time1
		echo "Your message will be timely notified!"
				
	elif [ $choice3 == 2 ]; then
		
		if [ -e $file_name1 ]; then
			echo "The file already exists."
			echo "You cannot make new to-do list under same date but can edit."
			continue
		else
			echo "To Do List---"
			echo "Press Enter and then Ctrl+D to save and exit." "Format: message time"
			echo "For example:"
			echo "Hello 4:00PM"
			echo
			
			user_input1=$(cat)

			echo "$user_input1" > "$file_name1"
			echo "Notes saved to: $file_name1"
			echo
			notified $file_name1
		fi
			
		
		
		
	elif [ $choice3 == 3 ]; then
		echo "After editing, press Ctrl+S to SAVE, and Ctrl+X to EXIT"
		sleep 2
		nano $file_name1
		echo "The file has been saved successfully."
		echo
		notified $file_name1
	
	elif [ $choice3 == 4 ]; then
		break
		
	else
		echo "Invalid Choice! Choose from [1-4]."
		
	fi
done

}




# CHANGING TIME FORMAT
function time_format(){
	current_format=$(gsettings get org.gnome.desktop.interface clock-format)

	if [ "$current_format" == "'12h'" ]; then
	    # Switch to 24-hour format
	    gsettings set org.gnome.desktop.interface clock-format "'24h'"
	    echo "Time format switched to 24-hour."
	else
	    # Switch to 12-hour format
	    gsettings set org.gnome.desktop.interface clock-format "'12h'"
	    echo "Time format switched to 12-hour."
	fi
}




# CHANGING TIME-ZONE
function time_zone(){
	while :; do
	echo "1. To display available Time-Zones."
	echo "2. Search for your own country/continents."
	echo "3. To change the time according to the given Time-Zone."
	echo "4. Exit."
	echo "Choose from [1-4]:"
	read choice5

	if [ $choice5 == 1 ]; then
		echo "Available time formats:"
		# timedatectl list-timezones > time_zone.txt
		cat time_zone.txt	# already stored contents in the file named time_zone.txt
	
	elif [ $choice5 == 2 ]; then
		echo "The below are the countries/continents available:"
		sleep 2
		awk -F'/' '{print $1}' time_zone.txt | sort | uniq
		
		echo "To search for your own country/ continent: "
		read name
		grep -i $name time_zone.txt

	elif [ $choice5 == 3 ]; then
		read -p "Enter the desired time zone (e.g., 'America/New_York'): " timezone

		# Validate the provided time zone
		if timedatectl list-timezones | grep -q "^$timezone\$"; then
			sudo timedatectl set-timezone "$timezone"
			echo "Time zone changed to $timezone"
		else
			echo "Invalid time zone. Choose Option 1 to see the available Time-Zones"
		fi
			
	elif [ $choice5 == 4 ]; then
		break
	
	else
		echo "Invalid Choice! Choose from [1-4]."
	fi
	
	done


}



# Menu Driven Program
while :; do
echo
echo "--Menu Driven Program--"
echo "1. Set Alarm."		
echo "2. Writing Diary."	
echo "3. Set Reminders."	
echo "4. Change Time-Format."	
echo "5. Change Time-Zone."	
echo "6. Exit."			

read -p "Choose from [1-6]: " choice; echo

	case $choice in
		1)set_alarm;;
		2)diary;;
		3)set_reminders;;
		4)time_format;;
		5)time_zone;;
		6)echo "See You Again!"; echo "Time Manangement Signing off."
		  exit 0;;
		*)echo "Invalid Choice!" "Choose from [1-6]";;
	
	esac
done

	

