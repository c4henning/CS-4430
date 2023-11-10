import mysql.connector

cnx = None
failed_connection_attempts = 0
while True:
    try:
        cnx = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="northwind"
        )

    except mysql.connector.errors.DatabaseError as e:
        failed_connection_attempts += 1
        print(e)
        if failed_connection_attempts < 3:
            print("reattempting connection...")
        elif input("unable to connect. retry? y/n: ").lower().startswith('y'):
            failed_connection_attempts = 0
        else:
            quit("connection failed; exiting.")

    else:
        print("connected to MySQL server")
        cursor = cnx.cursor()
        break
# CODE BELOW #############################################################


# CODE ABOVE #############################################################
cnx.rollback()
cursor.close()
cnx.close()
