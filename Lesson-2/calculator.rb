require 'yaml'
STRINGS = YAML.load_file('calculator.yml')
LANG = 'en'

def message(lang, msg_key)
  STRINGS[lang][msg_key]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(num)
  Integer(num) rescue false
end

def float?(num)
  Float(num) rescue false
end

def number?(num)
  integer?(num) || float?(num)
end

def operation_to_message(op)
  ret = case op
        when '1'
          message(LANG, 'OperatorToMsg')['Add']
          STRINGS[LANG]['OperatorToMsg']['Add']
        when '2'
          message(LANG, 'OperatorToMsg')['Sub']
        when '3'
          message(LANG, 'OperatorToMsg')['Mul']
        when '4'
          message(LANG, 'OperatorToMsg')['Div']
        end
  ret
end

prompt(message(LANG, 'WelcomeMessage'))

loop do # main loop
  first = nil
  loop do
    prompt(message(LANG, 'PromptFirstNumber'))
    first = Kernel.gets().chomp()

    if number?(first)
      break
    else
      prompt(message(LANG, "InvalidNumber"))
    end
  end

  second = nil
  loop do
    prompt(message(LANG, 'PromptSecondNumber'))
    second = Kernel.gets().chomp()

    if number?(second)
      break
    else
      prompt(message(LANG, "InvalidNumber"))
    end
  end

  operator = nil
  prompt(message(LANG, 'OperatorPrompt'))
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(message(LANG, "InvalidOperator"))
    end
  end

  prompt("#{operation_to_message(operator)} #{message(LANG, 'Calculating')}")

  result =  case operator
            when '1'
              first.to_i() + second.to_i()
            when '2'
              first.to_i() - second.to_i()
            when '3'
              first.to_i() * second.to_i()
            when '4'
              first.to_f() / second.to_f()
            end

  prompt("#{message(LANG, 'Result')} #{result}")

  prompt(message(LANG, 'Repeat?'))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
