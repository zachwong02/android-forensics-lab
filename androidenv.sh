#!/bin/bash

# Written by: Wong Zhi Zhen
# Phone Emulated: Pixel_2_29_Q
# Host Machine: M1 Macbook Air 2020
# Original use for BATCTF2023

# Make sure to link specific files first:
# https://proandroiddev.com/android-emulator-change-your-sim-card-number-8c7a72bc185a

# Make sure to root the phone first:
# https://samsclass.info/128/proj/M142.htm

# Useful commands:
# https://gist.github.com/Pulimet/5013acf2cd5b28e55036c82c91bd56d8

# Set values
emulator="emulator-5554"

# Set the host and port
host="localhost"
port="5554"

apps=("discord.apk" "notepad.apk")

# Phone Numbers
coco="601165012665"
brandon="601163282118"
alan="601110288282"

reply_messages=("Hey Coco, are you there? I need to talk to you about something really important." "I overheard Alan talking on the phone today. He sounded really angry and desperate." "Well, I couldn't catch the entire conversation, but he mentioned something about making sure his friends would never betray him again." "No, it was an unidentified voice. But his tone was filled with anger and desperation. It worried me." "I think we should stay away from him for a while and keep our distance." "No problem. Take care, we'll talk again soon.")
incoming_messages=("Yeah, David, I'm here. What's going on?" "Wait, seriously? What did he say?" "That doesn't sound good. Did you recognize the person he was talking to?" "We need to be careful around him." "Agreed. We don't want to put ourselves in any unnecessary danger. Let's look out for each other. Thanks for letting me know about this." "You too. Stay safe and keep me updated if you hear anything else.") 


# Functions

set_time(){
  echo -e "\033[96m[\033[31m*\033[96m] \033[39mSetting the date"
  adb -s $emulator shell "su -c 'toybox date $1'"
}

make_call(){
  echo -e "\033[96m[\033[31m*\033[96m] \033[39mMaking a call"

  set_time $2
  sleep 5
  adb -s $emulator shell am start -a android.intent.action.CALL -d tel:$1
  sleep 10
  adb -s $emulator shell input keyevent 6
}


receive_call(){
  echo -e "\033[96m[\033[31m*\033[96m] \033[39mReceiving a call"
  set_time $2
  sleep 5
  echo "gsm call $1" >&3
  sleep 10
  echo "gsm cancel $1" >&3

}

send_message(){
      adb -s $emulator shell am start -a android.intent.action.SENDTO -d sms:$1 --es sms_body \"$2\"
      sleep 1
      adb -s $emulator shell input keyevent 22
      sleep 1
      adb -s $emulator shell input keyevent 66
}

receive_message(){
  echo "sms send $1 $2" >&3
}

insert_images(){
  adb -s $emulator push $1 /storage/self/primary/DCIM/
}

log(){
  echo -e "\033[96m[\033[31m*\033[96m] \033[39m$1"  
}

send_keystokes(){
  adb -s $emulator shell input keyevent $1
}

clear

# Install apps
log "Installing Applications"

for app in "${apps[@]}"; do
  adb -s $emulator install "<REDACTED>/apps/$app"
done


# Connect to the netcat service
exec 3<>/dev/tcp/$host/$port

if [ $? -eq 0 ]; then
  log "Connecting to device"
  log "Connected to $host:$port"

  # Sends the auth code to authorise commands
  log "Authorising access"
  # echo "auth wiSSBsQl+s7EDPbU" >&3
  echo "auth +vQbacxAKClrTwyM" >&3


  log "Configuring message settings"
  
  # Launches the messaging app and disables AI stuff
  log "Enabling root"
  adb -s $emulator shell su &
  send_keystokes 22 
  sleep 1 
  send_keystokes 22 
  sleep 1
  send_keystokes 22 
  send_keystokes 66 
  log "root enabled!"

  log "Disabling messaging suggestions"
  adb -s $emulator shell am start -n com.google.android.apps.messaging/.ui.ConversationListActivity


  send_keystokes 61 
  send_keystokes 61 
  send_keystokes 61 
  send_keystokes 61 
  send_keystokes 61 
  send_keystokes 61 
  send_keystokes 66

  send_keystokes 20
  send_keystokes 20
  send_keystokes 20
  send_keystokes 20
  send_keystokes 66
  
  send_keystokes 20
  send_keystokes 20
  send_keystokes 20
  send_keystokes 20
  send_keystokes 66
  

  send_keystokes 66
  send_keystokes 20
  send_keystokes 20
  send_keystokes 66
  send_keystokes 20
  send_keystokes 20
  send_keystokes 66



  # # Actually sends the messages
  log "Sending messages"

  log "Setting date to [26 August 2023, 21:00:07 GMT+8]"
  set_time 0826210023.00

  receive_message 1098 "Limited time offer: Buy one, get one free!"
  sleep 3
  receive_message 1824 "Experience luxury with our 5-star hotel deals."
  sleep 3
  receive_message 6089 "Verification code: 7421. Keep it confidential!"
  sleep 3
  receive_message 5368 "Get 20% off on all electronics today!"
  sleep 3
  receive_message 7532 "Your 2FA code is 8742."
  sleep 3
  receive_message 4217 "Please enter 2875 to complete verification."
  sleep 3
  receive_message 6089 "Enter code 5369 for verification."
  sleep 3
  receive_message 8416 "Satisfy your cravings with our delicious desserts."
  sleep 3
  receive_message 5632 "Upgrade your wardrobe with our latest collection."
  sleep 3
  receive_message 6089 "Check out our latest video! https://www.youtube.com/watch?v=xvFZjo5PgG0"
  sleep 3
  receive_message 6890 "Use code 1984 to secure your account."
  sleep 3

  for i in "${!reply_messages[@]}"; do
      incoming_message="${incoming_messages[$i]}"
      reply_message="${reply_messages[$i]}"
      
      sleep 8
      send_message $coco "$reply_message"
      sleep 10
      receive_message $coco "$incoming_message"
  done

  receive_call $alan 0824093023
  receive_call $alan 0824152023
  receive_call $alan 0825011023
  make_call $coco 0825035523
  receive_call $alan 0825072523
  receive_call $alan 0825135023
  receive_call $alan 0825203023
  receive_call $alan 0826054023
  make_call $coco 0826081523
  receive_call $alan 0826112023
  receive_call $coco 0826144523
  receive_call $alan 0826171023
  make_call $coco 0826202523
  receive_call $alan 0827015023
  receive_call $alan 0827043523
  receive_call $alan 0827075523
  receive_call $coco 0827101023
  receive_call $alan 0827132523
  receive_call $alan 0827164023

  log "Transferring pictures"  
  insert_images '<REDACTED>/police_3_4/memes/*'


  log "Transferrring other data"
  

  # To do manually  
  log "Add note about a key [FRIENDSFOREVER]"
  log "Create a message about creating a Discord Server discreetly"
  log "Add a note about adding people to contacts"

  # Display a message prompting the user to press any key
  echo "Press any key to acquire disk image..."
  
  # Disable line buffering to read input immediately
  stty -echo
  stty cbreak
  
  # Read a single character from the user
  read -n 1 key
  
  # Enable line buffering and echoing
  stty echo
  stty -cbreak
  
  # Perform an action based on the input received
  echo  # Move to a new line

  log "Acquiring disk image"
  adb -s $emulator shell "su -c 'tar --exclude=android_image.tar.gz -cvzf /sdcard/Download/android_image.tar.gz /data'" 
  adb pull /sdcard/Download/android_image.tar.gz
  log "Acquired disk image!"


#   # Close the connection
  exec 3>&-
else
  echo "Connection to $host:$port refused"
fi
