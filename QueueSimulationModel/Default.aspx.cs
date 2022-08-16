using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace QueueSimulationModel
{
    public partial class _Default : Page
    {
        int ArrivalType;
        int ServiceType;
        float ArrivalTime;
        float ServiceTime;
        int Candidates;
        int ServiceCustomers;
        int NoOfServers;
        float lambda, mu, serverUtilizationFactor;
        protected void Page_Load(object sender, EventArgs e)
        {
            dvRightPanel.Visible = false;
        }

        protected void btnSimulate_Click(object sender, EventArgs e)
        {
            lblErrors.Text = "";
            if (Validate())
            {
                lblErrors.Visible = false;
                dvRightPanel.Visible = true;
                serverUtilizationFactor = lambda / (mu * NoOfServers);


                //Service Utilization                 
                txtServerUtilization.Text = Math.Round(serverUtilizationFactor * 100).ToString() + " %";

                //Server Idle 
                txtServerIdle.Text = Math.Round((1 - serverUtilizationFactor) * 100).ToString() + " %";

                if (NoOfServers == 1)
                {
                    //Average Length of System 
                    txtAvgLengthSys.Text = (Math.Round(lambda / (mu - lambda))).ToString();

                    //Average Length of Queue
                    txtAvgLengthQueue.Text = (Math.Round(float.Parse(txtAvgLengthSys.Text) * serverUtilizationFactor)).ToString();

                    //Average System Wait
                    txtAvgSystemWait.Text = ((int)Math.Round(1 / (mu - lambda))).ToString("00") + ":00";


                    //Average Queue Wait 
                    //Formula ==> Avg System Wait  * (lambda / mu)
                    txtAvgQueueWait.Text = ((int)Math.Round(int.Parse(txtAvgSystemWait.Text.Split(':')[0]) * serverUtilizationFactor)).ToString("00") + ":00";

                }
                else if (NoOfServers > 1)
                {
                    //Average Length of Queue
                    //Formula ==> 1 / (Σ m=0 to c-1 ((c*server utilization)^m)/m!)+ (c*server utilization)^m)/c!*(1-server utilization)
                    double summation = 0;
                    for (int i = 0; i < NoOfServers; i++)
                    {
                        summation += (double)Math.Pow(serverUtilizationFactor * NoOfServers, i) / (double)Factorial(i);
                    }


                    double rest = (double)Math.Pow(NoOfServers * serverUtilizationFactor, NoOfServers) / (double)Factorial(NoOfServers) * (1 - serverUtilizationFactor);
                    double Po = 1 / (summation + rest);
                    double avgQueue = (Po * Math.Pow(lambda / mu, NoOfServers) * serverUtilizationFactor) / ((double)Factorial(NoOfServers) * Math.Pow(1 - serverUtilizationFactor, 2));
                    txtAvgLengthQueue.Text = Math.Round(avgQueue).ToString();


                    //Average Length of System
                    //Formula ==> (avg Queue + (lambda / mu))

                    double avgLen = avgQueue + (lambda / mu);

                    txtAvgLengthSys.Text = Math.Round(avgLen).ToString();


                    //Average Queue Wait 
                    //Formula ==> Avg System Wait  * (lambda / mu)

                    double avgQueueWait = avgQueue / lambda;
                    txtAvgQueueWait.Text = ((int)Math.Round(avgQueueWait)).ToString("00") + ":00";


                    //Average System Wait 
                    //Formula ==>  avgQueueWait + (1 / mu)
                    txtAvgSystemWait.Text = ((int)Math.Round(avgQueueWait + (1 / mu))).ToString("00") + ":00";

                }

                

            }
            else
            {
                lblErrors.Visible = true;
                dvRightPanel.Visible = false;
            }
        }

        private bool Validate()
        {
            bool result = false;
            //if (ddArrival.SelectedValue == "-1")
            //{
            //    result = false;
            //}
            //ddService check if selected

            ArrivalType = Convert.ToInt16(ddArrival.SelectedValue);
            ServiceType = Convert.ToInt16(ddService.SelectedValue);

            float.TryParse(txtArrivalTime.Text.Trim(), out ArrivalTime);
            float.TryParse(txtServiceTime.Text.Trim(), out ServiceTime);
            int.TryParse(txtCandidate.Text.Trim(), out Candidates);
            int.TryParse(txtServiceCandidate.Text.Trim(), out ServiceCustomers);
            NoOfServers = int.Parse(txtServer.Text.Trim());

            if (ArrivalType == (Int32)EnumArrivalType.ArrivalRate)
            {
                lambda = Candidates / ArrivalTime;
            }
            else
            {
                lambda = 1 / ArrivalTime;
            }

            if (ServiceType == (Int32)EnumServiceType.ServiceRate)
            {
                mu = ServiceCustomers / ServiceTime;
            }
            else
            {
                mu = 1 / ServiceTime;
            }

            if (lambda >= NoOfServers * mu)
            {
                lblErrors.Text += "Lambda value should not be greater than " + NoOfServers + " times mu";
                result = false;
                return result;
            }


            result = true;
            return result;
        }

        private void Refresh()
        {
            ddArrival.SelectedIndex = ddService.SelectedIndex = -1;
            txtArrivalTime.Text = txtServer.Text = txtCandidate.Text = txtServiceTime.Text = "";
            txtCandidate.Visible = lblCandidate.Visible = true;
        }

        private int Factorial(int number)
        {
            int fact = 1;
            try
            {
                if (number > 0)
                {
                    fact = number;
                    for (int i = number - 1; i >= 1; i--)
                    {
                        fact = fact * (--number);
                    }
                }
            }
            catch (Exception ex)
            {
            }

            return fact;
        }

        enum EnumArrivalType
        {
            ArrivalRate,
            MeanArrivalRate
        }

        protected void ddService_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddService.SelectedValue == "1")
            {
                dvServiceCandidate.Visible = false;
                lblServiceRate.Text = "ServiceRate = 1 / Service Time";
            }
            else
            {
                dvServiceCandidate.Visible = true;
                lblServiceRate.Text = "ServiceRate= No Of Service / Unit Time";
            }
        }

        protected System.Void Page_Load(System.Object sender, System.EventArgs e)
        {

        }

        enum EnumServiceType
        {
            ServiceRate,
            MeanServiceRate
        }

        protected void ddArrival_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddArrival.SelectedValue == "1")
            {
                txtCandidate.Visible = lblCandidate.Visible = false;
            }
            else
            {
                txtCandidate.Visible = lblCandidate.Visible = true;
            }
        }
    }
}