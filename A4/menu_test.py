def fancy_input(prompt):
    print("╔══════════════════════════════════════════╗")
    user_input = input(f"║ {prompt: <40} ║\n")
    print("╚══════════════════════════════════════════╝")
    return user_input

user_input = fancy_input("Enter your input:")
