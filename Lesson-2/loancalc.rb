def prompt(msg)
  Kernel.puts("=> #{msg}")
end

def integer?(num)
  Integer(num) rescue false
end

def float?(num)
  Float(num) rescue false
end

def valid_float?(num)
  float?(num) && num > 0
end

def valid_integer?(num)
  integer?(num) && num > 0
end

def calculate_monthly_payment(apr, principal, duration)
  monthly_interest = apr / 12.0 / 100
  monthly_payment = principal *
                    (monthly_interest /
                      (1 - (1 + monthly_interest)**(-duration)))
  monthly_payment
end

prompt("Mortgage Calculator v0.0.1b")

loop do
  principal = nil
  loop do
    prompt("Enter the loan principal")
    principal = Kernel.gets().chomp()
    break if !principal.empty?() && valid_float?(principal.to_f())
    prompt("Invalid entry, enter a positive number.")
  end

  apr = nil
  loop do
    prompt("Enter the APR (Example, 2 for 2%, 6.7 for 6.7%, etc")
    apr = Kernel.gets().chomp()
    break if !apr.empty?() && valid_float?(apr.to_f())
    prompt("Invalid entry, enter a positive number.")
  end

  duration = nil
  loop do
    prompt("Enter the loan duration in months")
    duration = Kernel.gets().chomp()
    break if valid_integer?(duration.to_i()) && !duration.empty?()
    prompt("Invalid entry, Enter only a whole numbers.")
  end

  calc_monthly = calculate_monthly_payment(apr.to_f(),
                                           principal.to_f(),
                                           duration.to_i())
  prompt("Monthly Payment is $#{format('%.2f', calc_monthly)}.")
  prompt("Monthly Interest is #{apr.to_f() / 12}%")
  prompt("Loan duration is #{duration} months.")

  prompt("Do you wish to run another calculation? (Y/n)")
  run_another = Kernel.gets().chomp()
  break unless run_another.downcase.start_with?('y')
end
