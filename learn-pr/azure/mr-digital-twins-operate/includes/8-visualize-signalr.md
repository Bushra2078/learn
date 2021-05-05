> [!NOTE]
> Remember to stop the simulator whenever it’s not needed, to avoid unnecessary charges on your Azure account.

Use the Visual Studio DeviceSimulator solution to simulate a wind farm, sending telemetry data to ADT, where your newly configured Digital Twin in Unity receives input and displays operating conditions on the wind farm.

## Begin the wind farm device simulation

1.	In the Visual Studio IDE, open **DeviceSimulator.sln**, which can be found in the functions folder and contains the DeviceSimulator solution. 
2.	Run the **DeviceSimulator** by pressing the **Play** button or **F5**
3.	A Command window will open displaying Turbine IDs and messages indicating connectivity and device retrieval / creation

<!-- :::image type="content" source="" alt-text=""::: -->

4.	Press any key to begin the simulation.  Be aware that this simulation generates a significant amount of data, simulating real world operations, and Azure consumption will occur. If configured properly and connected to the correct Azure services, you'll see a series of streaming console messages **Message Received**, indicating that the ADT services have acknowledged the receipt of the simulated IoT data.

## Launch the Digital Twin in Unity Editor

1.	Press the **Play** button in the Unity Editor.  You'll notice that the Editor switches to the Game tab automatically and begins rendering your Scene.  You'll see the data in the UI panels reflect the data being generated from the **DeviceSimulator** application running. 

<!-- :::image type="content" source="" alt-text=""::: -->

2.	Navigate in the **Game** tab, by pressing and holding your **right mouse button** while you navigate.  When you hover over a turbine (moving the white circle) or a turbine name in the **Site Overview Menu** panel, you see the **Turbine Panel** with specifics for that Turbine asset.

<!-- :::image type="content" source="" alt-text=""::: -->

3.	Observe what happens to the data displayed in the **Site Overview Menu** and **Turbine Panel** in your Unity **Game** view.

<!-- :::image type="content" source="" alt-text=""::: -->

4.	Observe wind turbine performance data by selecting the Scriptable Object of interest.  Select **Assets > ScriptableObjects > Turbine Site Data > T103** and examine the incoming sta in the **Wind Turbine Data** section of the **Inspector** Panel.  You should see the **Time Interval, Wind Speed, Ambient Temperature, Rotor Speed and Power** fluctuate as new telemetry messages are consumed by the application.

<!-- :::image type="content" source="" alt-text=""::: -->


## Stop the DeviceSimulator

1.	This is important to ensure you avoid unnecessary charges to your Azure account
2.	Press **Ctrl-C** in the Command Window or the **Stop** button in the Visual Studio IDE