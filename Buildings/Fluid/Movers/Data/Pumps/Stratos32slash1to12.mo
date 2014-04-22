within Buildings.Fluid.Movers.Data.Pumps;
record Stratos32slash1to12 "Pump data for a Wilo Stratos 32/1-12 pump"
  extends Generic(
    N_nominal=3580,
    P_max=310,
    N_min=1400,
    N_max=4800,
    use_powerCharacteristic=true,
    power(V_flow={2.11830535572e-05,0.000167865707434,0.000700939248601,
          0.0012450039968,0.00177258193445,0.00227268185452,0.00272332134293,
          0.00312450039968,0.00345423661071}, P={103.427852653,110.225580543,
          135.414121033,162.955749719,191.043411366,216.051565678,230.204882307,
          236.346847436,239.552825212}),
    pressure(V_flow={2.11830535572e-05,0.000167865707434,0.000700939248601,
          0.0012450039968,0.00177258193445,0.00227268185452,0.00272332134293,
          0.00312450039968,0.00345423661071}, dp={59279.4925671,59115.2927989,
          59000.1476354,57351.238791,54446.2693068,50284.7374612,44865.6398104,
          38328.4550274,32066.9663984}));
  annotation (Documentation(info="<html>
<p>Data from: <a href=\"http://productfinder.wilo.com/en/COM/product/00000018000029770002003a/fc_product_datasheet\">http://productfinder.wilo.com/en/COM/product/0000000e000379df0002003a/fc_product_datasheet</a></p>
<p>See <a href=\"modelica://Buildings.Fluid.Movers.Data.Pumps.Stratos25slash1to6\">Buildings.Fluid.Movers.Data.Pumps.Stratos25slash1to6</a> for more information about how the data is derived.</p>
</html>", revisions="<html>
<ul>
<li>April 22, 2014
    by Filip Jorissen:<br/>
       Initial version
</li>
</ul>
</html>"));
end Stratos32slash1to12;
