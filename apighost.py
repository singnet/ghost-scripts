import subprocess as sp
import os

from pip._vendor.distlib.compat import raw_input

class whole:
    def __init__(self):
        self.isRelex = False
        self.takeInput()

    def takeInput(self):
        if (self.isRelex == False):
            self.startRelex()
            self.isRelex = True

        value = raw_input("Please enter your rule or '(quit)' to exit: ")
        if (value == "(quit)"):
            found = raw_input("Are you sure? Y or N: ")
            if found == "Y" or found == "y":
                raise SystemExit
            elif found == "N" or found == "n":
                self.takeInput()
        print(self.startGuile(value.decode()))
        self.takeInput()

    def startRelex(self):
        print("-------opening relex server------------")
        # sp.call('./opencog-server.sh', cwd='/home/abeni/relex')
        os.chdir("/home/cogbot-developer/hansonrobotics/OPENCOG/relex/")

        os.system("gnome-terminal -e 'bash -c \"./opencog-server.sh; exec bash\"'")

        # if it is using docker
        # subprocess.call('sudo docker run -it -p 4444:4444 opencog/relex /bin/sh opencog-server.sh', shell=True)

    def startGuile(self, value):
        # def startGuile():
        print("--------------------starting GUILE--------------")
        proc = sp.Popen('guile', stdin=sp.PIPE, stdout=sp.PIPE, stderr=sp.STDOUT, shell=True)

        # a = proc.communicate(input=None)
        a = proc.stdout.readline()
        # print(type(a))
        # print(a)

        if ("GNU Guile" in a):
            print("guile successfully opened")
        else:
            print("there is a problem with guile")

        try:
            module = b"""
						(use-modules(opencog)
						(opencog nlp)
						(opencog nlp relex2logic)
						(opencog openpsi)
						(opencog ghost) 
						(opencog ghost procedures))"""
            proc.stdin.write(module)
        # print(type(h))
        # print("Modules successfully loaded")
        except ValueError:
            print("problem occured while trying to load modules ")

        try:
            code = b"""
					(ghost-parse "u: (hello) hi there")
					"""
            proc.stdin.write(code)
            test = b"""
					(map cog-name (test-ghost "hello"))
					"""
            # a1 = test.decode()
            # a2 = a1.encode()
            # #print(type(a1))
            # #print(type(a2))
            g = proc.stdin.write(test)

            print("Test completed successfully!")


        except:
            print("Problem occured on test.")
        # print(proc.communicate())

        try:
            proc.stdin.write(value)
            print(proc.communicate())
        # b = proc.stdout.readline()
        # print(b)

        # r = b"""
        #   		(map cog-name (test-ghost "brook"))
        #   		"""
        # proc.stdin.write(r)
        except:
            print("Error while executing code!")

    # print(proc.communicate())


# isRelex = False
print("-------------Welcome-------------")
one = whole()

# def main():
#     # startRelex()
# 	# startGuile()
#  	takeInput()

# if __name__ == '__main__':
#     main()

