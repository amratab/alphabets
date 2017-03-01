class AlphabetSkillHandler < AlexaSkillsRuby::Handler
  on_launch do
    response.set_output_speech_text("Welcome to alphabet Teacher. What is A for?")
    response.should_end_session = false
  end

  on_intent("AlphabetWordIntent") do
    slots = request.intent.slots
    puts slots
    response.set_output_speech_text("You said #{slots['AlphabetWord']}")
  end
end
