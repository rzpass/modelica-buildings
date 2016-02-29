within Buildings.Fluid.Movers;
model FlowControlled_m_flow
  "Fan or pump with ideally controlled mass flow rate as input signal"
  extends Buildings.Fluid.Movers.BaseClasses.FlowControlled(
    final control_m_flow=true,
    preSou(m_flow_start=m_flow_start),
    final stageInputs(each final unit="kg/s")=massFlowRates,
    final constInput(final unit="kg/s")=constantMassFlowRate,
    filter(
     final y_start=m_flow_start,
     u_nominal=m_flow_nominal,
     u(final unit="kg/s"),
     y(final unit="kg/s")));

  // Classes used to implement the filtered speed
  parameter Boolean filteredSpeed=true
    "= true, if speed is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Filtered speed"));
  parameter Modelica.SIunits.Time riseTime=30
    "Rise time of the filter (time to reach 99.6 % of the speed)"
    annotation(Dialog(tab="Dynamics", group="Filtered speed",enable=filteredSpeed));
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Filtered speed",enable=filteredSpeed));
  parameter Modelica.SIunits.MassFlowRate m_flow_start(min=0)=0
    "Initial value of mass flow rate"
    annotation(Dialog(tab="Dynamics", group="Filtered speed"));
  parameter Modelica.SIunits.MassFlowRate constantMassFlowRate=m_flow_nominal
    "Constant pump mass flow rate, used when inputType=Constant"
    annotation(Dialog(enable=inputType == Buildings.Fluid.Types.InputType.Constant));

  parameter Modelica.SIunits.MassFlowRate[:] massFlowRates = m_flow_nominal*{0}
    "Vector of mass flow rate set points, used when inputType=Stage"
    annotation(Dialog(enable=inputType == Buildings.Fluid.Types.InputType.Stages));

  Modelica.Blocks.Interfaces.RealInput m_flow_in(
    final unit="kg/s",
    nominal=m_flow_nominal) if
       inputType == Buildings.Fluid.Types.InputType.Continuous
    "Prescribed mass flow rate"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-2,120})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_actual(
    final unit="kg/s",
    nominal=m_flow_nominal) "Actual mass flow rate"
    annotation (Placement(transformation(extent={{100,40},{120,60}}),
        iconTransformation(extent={{100,40},{120,60}})));

protected
  Sensors.RelativePressure senRelPre(
    redeclare final package Medium = Medium) "Head of fan"
    annotation (Placement(transformation(extent={{45,-25},{55,-15}})));
equation
  if filteredSpeed then
    connect(inputSwitch.y, filter.u) annotation (Line(
      points={{1,50},{10,50},{10,88},{18.6,88}},
      color={0,0,127},
      smooth=Smooth.None));
    connect(filter.y, m_flow_actual) annotation (Line(
      points={{34.7,88},{40,88},{40,50},{110,50}},
      color={0,0,127},
      smooth=Smooth.None));
  else
    connect(inputSwitch.y, preSou.m_flow_in) annotation (Line(
      points={{1,50},{44,50},{44,8}},
      color={0,0,127},
      smooth=Smooth.None));
  end if;
    connect(m_flow_actual, preSou.m_flow_in) annotation (Line(
      points={{110,50},{44,50},{44,8}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(inputSwitch.u, m_flow_in) annotation (Line(
      points={{-22,50},{-26,50},{-26,80},{0,80},{0,120}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senRelPre.port_a, preSou.port_a) annotation (Line(points={{45,-20},{
          20,-20},{20,0},{40,0}},
                               color={0,127,255}));
  connect(senRelPre.port_b, preSou.port_b) annotation (Line(points={{55,-20},{80,
          -20},{80,0},{60,0}}, color={0,127,255}));
  connect(senRelPre.p_rel, eff.dp) annotation (Line(points={{50,-24.5},{50,-30},
          {-35,-30},{-35,-44},{-32,-44}}, color={0,0,127}));
  annotation (defaultComponentName="fan",
  Documentation(
   info="<html>
<p>
This model describes a fan or pump with prescribed mass flow rate.
The efficiency of the device is computed based
on the efficiency curves that take as an argument
the actual volume flow rate divided by the maximum possible volume flow rate.
</p>
<p>
See the
<a href=\"modelica://Buildings.Fluid.Movers.UsersGuide\">
User's Guide</a> for more information.
</p>
</html>",
      revisions="<html>
<ul>
<li>
April 2, 2015, by Filip Jorissen:<br/>
Added code for supporting stage input and constant input.
</li>
<li>
January 6, 2015, by Michael Wetter:<br/>
Revised model for OpenModelica.
</li>
<li>
February 14, 2012, by Michael Wetter:<br/>
Added filter for start-up and shut-down transient.
</li>
<li>
May 25, 2011, by Michael Wetter:<br/>
Revised implementation of energy balance to avoid having to use conditionally removed models.
</li>
<li>
July 27, 2010, by Michael Wetter:<br/>
Redesigned model to fix bug in medium balance.
</li>
<li>March 24, 2010, by Michael Wetter:<br/>
Revised implementation to allow zero flow rate.
</li>
<li>October 1, 2009
    by Michael Wetter:<br/>
       Model added to the Buildings library.
</ul>
</html>"),
    Icon(graphics={
        Text(
          visible = inputType == Buildings.Fluid.Types.InputType.Continuous,
          extent={{22,146},{114,102}},
          textString="m_flow_in"),
        Line(
          points={{32,50},{100,50}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(extent={{50,68},{100,54}},
          lineColor={0,0,127},
          textString="m_flow"),
        Text(
          visible=inputType == Buildings.Fluid.Types.InputType.Constant,
          extent={{-80,136},{78,102}},
          lineColor={0,0,255},
          textString="%m_flow_nominal")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})));
end FlowControlled_m_flow;
