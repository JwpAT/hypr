#!/bin/bash

sleep 15

messages=(
  "Hi cutie 🥰 hope you have a great day!"
  "You're doing amazing, don’t forget 💖"
  "Stay hydrated, pretty one ✨"
  "Faith would be proud of you 🌈"
  "You’re enough just as you are 🫶"
  "You're AMAZING :3 💗"
  "Be you!! 🏳️‍🌈"
  "Who wants a hug? You do!! 😊"
  "lock in today! smile!! 😀❤️"
  "Good morning sunshine ☀️ you make the world brighter just by being in it"
  "Keep that gorgeous smile going 😘 it looks good on you"
  "Deep breath sweetie 🫂 you are safe, you are loved, you are doing great"
  "Lil reminder 💌 you don’t need to be perfect, just be yourself"
  "Wiggle your toes 🦶 stretch your arms 💪 your body loves you too"
  "Queer and magical ✨ never let anyone dim that sparkle"
  "Soft hug for you right now 🤗 you deserve comfort and care"
  "Drink water 💧 take a snack 🍓 you deserve little joys all day"
  "Your heart is golden 💛 thank you for being you"
  "You’ve got this babe 😎 one step at a time, always forward"
  "Silly goose alert 🦢 remember to have fun today too"
  "Faith isn’t just a name 🌈 it’s something inside you too"
  "Don’t forget: you are loved, you are cute, you are enough 🫶"
  "Smile at your screen right now 😄 look how adorable you are"
  "Take a deep breath cutie 🌿 you’re doing better than you think"
  "Little reminder 💌 you don’t have to do everything today to be worthy"
  "Drink some water 💧 stretch your shoulders 🤸 your body thanks you"
  "Your queerness is magical 🏳️‍🌈✨ carry it proudly today"
  "Even small steps are still forward progress 🌱 keep going"
  "Someone out there smiles just because you exist 😄💖"
  "Rest is not lazy, it’s care — and you deserve it 🛏️"
  "You’re allowed to take up space, to be soft, and to be seen 🫶"
  "Faith in yourself is the cutest thing you can wear 🌈💗"
  "Remember to laugh at something silly today 😂 it’s good medicine"
  "Your heart is kind, your brain is bright, your soul is glowing ✨"
  "The world is softer with you in it 🌸 never forget that"
  "Even messy days can still be beautiful 🎨 you are art in progress"
  "Celebrate tiny wins, they add up to big victories 🏆"
  "Smile check 😁 because your smile really does light things up"
  "It’s okay to slow down — you don’t need to rush to be enough 🌿"
  "Cute reminder: you’ve survived 100% of your days so far 🌞"
  "Your vibe is precious, your joy is contagious, keep sharing it 💕"
  "Be silly, be kind, be you — it’s more than enough 🦢💗"
  "Right now, exactly as you are, you’re someone worth celebrating 🎉"

)

msg=${messages[$RANDOM % ${#messages[@]}]}

notify-send -a "CutePop" -t 8000 "💌 Daily Reminder" "$msg"

# show the notification
notify-send -t 8000 "💌 Daily Reminder" "$msg"

# if the message was the smile one, open the camera
if [[ "$msg" == "Smile at your screen right now 😄 look how adorable you are" ]]; then
    # open with cheese (simple GTK webcam app)
    sleep 3
    snapshot &

    # or, if you prefer mpv snapshot mode:
    # mpv av://v4l2:/dev/video0 --profile=low-latency --untimed --no-terminal --geometry=30%:30% &
fi
