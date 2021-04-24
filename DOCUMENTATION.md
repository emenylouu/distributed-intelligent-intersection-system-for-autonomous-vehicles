**Documentation**

1. **System description:**

The code was implemented using MATLAB and is composed of two classes; class Controller and class Coordinator, three optimization related functions; Fuel_consumption, dynamics, and update acceleration, three plotting functions, two bus objects for the CAVs and INFOs, one Signal object and a script to load the objects before running the simulation.

The simulation was designed in Simulink environment and SimEvents in which physical and non-physical components were put together and monitored, for instance, the connected automated vehicle (CAV) through a hybrid network. To communicate with the Infrastructure’s Agent or decision maker. 

The intersection simulation contains 5 principal subsystems:

| Subsystem                      | Description                                                  | Illustration                  |
| ------------------------------ | ------------------------------------------------------------ | ----------------------------- |
| Subsystem :OC vehicle dynamics | Takes 4 CAV input parameters and outputs 3 adjusted parameters using  QP according to the position, speed and flag status (1: cruiser / 0:  control). | Function Dynamics.m ()        |
| System2: Merging point.        | A queuing object in Simulink that Queues inputs in a FIFO list before  crossing the merging point. |                               |
| Subsystem3:Fuel Conception.    | Optimization Function that calculates the sum of three optimized  parameters (initial value, speed, velocity). | Function Fuel_concumption.m() |
| Subsystem4: Control Zone       | The decision maker who receives data, test it and optimize it using  CBFs, CLFs, and QP to optimize the CAVs functionalities and update their  Acceleration to assure a save intersection with the least fuel consumption  possible. |                               |
| Subsystem5: Coordinator        | Carries signals and data messages from the CAVs to the decision maker  and vice versa. |                               |

2. **System general parameters:** 

* **Vehicle characteristics:** (All CAVs have the same technical characteristics)

Vehicle (ID) , Position, Destination, Speed, Final speed,  Arrival time,  Final time,  Lane, Coefficient (acceleration update function), Vehicle’s Fuel consumption function.

* **Intersection characteristics:**

Lanes index, Intersection Control zone, Intersection merging region.

* **Intersection negotiation scenario:** 

When a connected automated vehicle approaches the intersection, and enters the control zone its VA shares its ID, position, speed, acceleration, color, lane going through. to the IMA-coordinator in order to get a time space occupancy reservation before it enters the intersection.

Based on the incoming reservation requests and the existing ones, the IMA-coordinator checks whether there is a conflict in time-space occupancy reservation between the existing reservation and the latest one according to the first in first out (FIFO) and optimal control (OC) algorithm. 

IF *there is a conflict in the reservation list* then the IMA-coordinator sends a pause message to the controller that gets the id of the vehicle and forwards that pause message, updates the vehicles acceleration and adjust its dynamics with the OC algorithm.

ELSE, *in case of no conflicts* the request will be approved and a continue message will be sent from IMA-coordinator to the controller that adjusts the vehicle’s dynamics and acceleration the reservation data will be updated. 

 The IMA-coordinator can communicate with the vehicles traveling inside the control zone and receive information from the environment. It is not involved in any decision making for any CAV and only enables communication of appropriate information among CAVs.