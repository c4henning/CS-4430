import mysql.connector

mydb = None
failed_connection_attempts = 0
while True:
    try:
        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            password=""
        )
        print("connected to MySQL server")
        break

    except mysql.connector.errors.DatabaseError as e:
        failed_connection_attempts += 1
        print(e)
        if failed_connection_attempts < 3:
            print("reattempting connection...")
        elif input("unable to connect. retry? y/n: ").lower().startswith('y'):
            failed_connection_attempts = 0
        else:
            quit("connection failed; exiting.")

print(mydb)
