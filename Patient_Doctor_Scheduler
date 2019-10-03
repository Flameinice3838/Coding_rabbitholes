###Final capstone project - Patient / Doctor Scheduler (Source: udemy Introduction to Python course)
# Spec: Create a patient class and a doctor class. Have a doctor that can handle multiple patients and setup a scheduling program where a doctor can only handle 16 patients during an 8 hr work day.

# create a list of registered doctor/patient names and their corresponding classes
docs = {}
pats = {}

# create a list of days and times to facilitate booking
days = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
times = ["8:00-8:30","8:30-9:00","9:00-9:30","9:30-10:00","10:00-10:30","10:30-11:00","11:00-11:30","11:30-12:00","13:00-13:30","13:30-14:00","14:00-14:30","14:30-15:00","15:00-15:30","15:30-16:00","16:00-16:30","16:30-17:00"]

# create patient class
class Patient():
    # allow patients to have bookings
    bookings = []

    def __init__(self,Name):
        self.Name = Name

    # have a string representation of the patient
    def __str__(self):
        return self.Name

# create doctor class
class Doctor():
    # create dictionary counting the number of patients the doctor has on each day
    n_patients = {"Monday":0,"Tuesday":0,"Wednesday":0,"Thursday":0,"Friday":0}
    # allow doctors to have bookings
    bookings = []
    
    def __init__(self,Name):
        self.Name = Name

    def add_patient(self,day):
        self.n_patients[day] += 1
        
    # have a string representation of the doctor
    def __str__(self):
        return self.Name

# define a method for a patient to choose a doctor
def choose_doc(chosen_doc):
    if chosen_doc in docs.keys():
        while True:
            day = str(input("Please enter your preferred day: "))
            if day.capitalize() in days:
                print("Thank you! Opening Doctor {}'s schedule...".format(chosen_doc))
                break
            else: 
                print("Sorry, please type one of 'Monday', 'Tuesday','Wednesday','Thursday' or 'Friday': ")
        return [docs[chosen_doc],day.capitalize()]
    else:
        print("Sorry, Doctor {} is not in the system. Please choose another doctor!".format(chosen_doc))

# define a method to make a booking for a given day. Make sure timeslots don't overlap between days
def make_booking(Doctor,Patient,day):
    if Doctor.n_patients[day] == 16:
        return "Sorry, Doctor {} is booking out on this day.".format(Doctor.Name)
    
    slots = {1:"8:00-8:30",2:"8:30-9:00",3:"9:00-9:30",4:"9:30-10:00",5:"10:00-10:30",6:"10:30-11:00",7:"11:00-11:30",8:"11:30-12:00",9:"13:00-13:30",10:"13:30-14:00",11:"14:00-14:30",12:"14:30-15:00",13:"15:00-15:30",14:"15:30-16:00",15:"16:00-16:30",16:"16:30-17:00"}
    # remove slots that are already booked by others for that day and time
    if len(Doctor.bookings) > 0:
        for booking in Doctor.bookings:
            for key,val in slots.items():
                if val in booking and booking[0] == day:
                    del slots[key]
                    break
    while True:
        try:
            time = int(input("Choose your slot (please enter the relevant corresponding number): {}\n".format(slots)))
            if time in slots:
                # append time to ease sorting when viewing schedules
                if Doctor.n_patients[day] < 16:
                    Patient.bookings.append([day,slots[time],Doctor.Name,time])
                    Doctor.bookings.append([day,slots[time],Patient.Name,time])
                    Doctor.add_patient(day)
                    print("Booking successfully made!")
                    break
                else:
                    print("Sorry, Doctor {} is booked out on this time and day.".format(Doctor.Name))
                    break
            else:
                print("Please enter a number in accordance with the available slots!")
                continue
        except:
            print("Please enter a number from 1 to 16, in accordance with the slots!")
            continue

# Python code to sort nested lists using fourth element  
# of sublist Inplace way to sort using sort() 
def Sort(sub_li): 
    # reverse = None (Sorts in Ascending order) 
    # key is set to sort using fourth element of  
    # sublist lambda has been used 
    sub_li.sort(key = lambda x: x[3]) 
    return sub_li 

# define a method for doctors and patients to view their bookings
# input schedule is type list
def view_booking(schedule):
    while True:
        see_bookings = str(input("Would you like to view your bookings? (Y or N): "))
        if see_bookings.capitalize() == "Y":
            if len(schedule) == 0:
                print("You have no bookings at the moment.")
                break
            else:
                # print bookings by day
                for day in days:
                    relevant_bookings = []
                    for booking in schedule:
                        if booking[0] == day:
                            relevant_bookings.append(booking)
                    # sort into chronological order
                    relevant_bookings = Sort(relevant_bookings)
                    if len(relevant_bookings) > 0:
                        print(day,": ")
                        for item in relevant_bookings:
                            print(item[1],": ",item[2])
                break
        elif see_bookings.capitalize() == "N":
            break
        else: 
            print("Please state whether you would like to view your bookings (Y) or not (N).")
            continue

# define method to register patients and doctors
def register(classtype, name):
    if classtype == "Doctor":
        name = Doctor(name)
        docs[name.Name] = name
    elif classtype == "Patient":
        name = Patient(name)
        pats[name.Name] = name

# run code!
system = True
while system:
    welcome = str(input("Welcome to the booking system! Please state you are a patient (1) or a doctor (2): "))
    # doctor
    if welcome == "2":
        introduce = str(input("Welcome! Please state your name: "))
        if introduce not in docs:
            print("Welcome Doctor {}! You have been registered to our doctors list.".format(introduce))
            register("Doctor",introduce)
            view_booking(docs[introduce].bookings)
        else:
            print("Welcome Doctor {}!".format(introduce))
            view_booking(docs[introduce].bookings)
        

    # patient
    elif welcome == "1":
        introduce = str(input("Welcome! Please state your name: "))
        if introduce not in pats:
            print("Welcome {}! You have been registered to our patient list.".format(introduce))
            register("Patient",introduce)
        else:
            print("Welcome {}!".format(introduce))

        asking = True
        while asking:
            ask_booking = str(input("Would you like to make a booking today? (Y or N)"))
            if ask_booking.capitalize() == "Y":
                # ask patient to choose a doctor to see
                processing = True
                while processing:
                    if len(docs) > 0:
                        chosen_doc = input("Please choose a doctor to see: {}".format(list(docs.keys())))
                        chosen = choose_doc(chosen_doc)
                        if chosen is None:
                            continue
                        # make one or more bookings
                        make_booking(chosen[0],pats[introduce],chosen[1])
                        again = ""
                        while again != "Y" and again != "N":
                            again = input("Would you like to make another booking? (Y or N): ")
                            if again.capitalize() == "Y":
                                continue
                            elif again.capitalize() == "N":
                                processing = False
                                asking = False
                            else:
                                print("Please confirm whether you would like to make another booking (Y) or not (N).")
                                continue
                    else:
                        print("Sorry, there are no doctors available at the moment. Please try again later.")
                        break
                break
            elif ask_booking.capitalize() == "N":
                break
            else:
                print("Please confirm whether you would like to make a booking (Y) or not (N).")
                continue

        view_booking(pats[introduce].bookings)
        
    else:
        print("Please confirm whether you are a patient (1) or a doctor (2)!")
        continue

    print("Thank you for using our system. Please come again!")
    system = False
