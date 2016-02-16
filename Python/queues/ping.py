import time

def main():
    for x in range(100):
        print x
        time.sleep(1)

if __name__ == '__main__':
    print("Starting")
    time.sleep(2)
    main()