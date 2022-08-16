<%@ Page Title="Interview Queue Simulator" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QueueSimulationModel._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >
  
    <link href="ExternalExternalStyleSheet.css" rel="stylesheet" type="text/css" /> 
    <style>

     .card {
    transition: transform .2s
}


    .card:hover {
        transform: scale(1.5);
    }


    </style>

    <div class="jumbotron">
        <a href="Default.aspx">
        <h1 class="text-center">Interview Simulation Model</h1>
        </a>
        <a href="About.aspx">
        <h6 class="text-center">Abous Us</h6>
        </a>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>M / M / C MODEL</h2>
            <div  style="font-size: large; font-style: normal; font-family: 'Segoe UI Variable Small Semibol'">
            <div class="row">
                <div>
                    <asp:Label Text="Arrival" runat="server" />
                </div>
                <div>
                    <asp:DropDownList runat="server" ID="ddArrival" OnSelectedIndexChanged="ddArrival_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Text="Select" Value="-1" />
                        <asp:ListItem Text="Arrival Rate" Value="0" />
                        <asp:ListItem Text="Mean Arrival Time" Value="1" />
                    </asp:DropDownList>
                    <asp:TextBox runat="server" ID="txtArrivalTime" Width="60" placeholder="00" />
                    <br />
                    <br />

                </div>
            </div>
            <div class="row">
                <div>
                    <asp:Label ID="lblCandidate" Text="Candidate" runat="server" />
                </div>
                <asp:TextBox runat="server" ID="txtCandidate" Width="60" MaxLength="3" placeholder="999" />
                <br />
                <br />
                <br />
            </div>
            <div class="row">
                <div>
                    <asp:Label Text="Service" runat="server" />
                </div>
                
                <div>
                    <asp:DropDownList runat="server" ID="ddService" OnSelectedIndexChanged="ddService_SelectedIndexChanged" AutoPostBack="true">

                        <asp:ListItem Text="Select" Value="-1" />
                        <asp:ListItem Text="Service Rate" Value="0" />
                        <asp:ListItem Text="Mean Service Time" Value="1" />
                    </asp:DropDownList>

                </div>
            </div>
            <div class="row">
                <div>
                    <asp:Label ID="lblServiceRate" Text="ServiceRate= No Of Customer / Service Time" runat="server" />
                </div>
                <div id="dvServiceCandidate" runat="server">
                    <asp:TextBox runat="server" ID="txtServiceCandidate" Width="60" MaxLength="3" placeholder="999" />
                    &nbsp / &nbsp
                </div>
                <asp:TextBox runat="server" ID="txtServiceTime" Width="60" placeholder="00" />

                <br />
                <br />
                <br />
            </div>
            <div class="row">
                <div>
                    <asp:Label Text="Time unit" runat="server" />

                </div>
                <asp:DropDownList runat="server" ID="ddTimeUnit">
                    <asp:ListItem Text="minutes" Value="0" />
                    <asp:ListItem Text="hours" Value="1" />
                </asp:DropDownList>

                <br />
                <br />
                <br />
            </div>
            <div class="row">
                <div>
                    <asp:Label Text="No of Servers" runat="server" />
                </div>
                <asp:TextBox runat="server" ID="txtServer" Width="60" MaxLength="3" placeholder="999" />
                <br />
                <br />
                <br />
            </div>
            <div class="row">
                <asp:Button Text="Simulate" ID="btnSimulate" runat="server" OnClick="btnSimulate_Click" />
            </div>
                
            </div>

        </div>
        
            <div class="col-md-8">
                <div class ="LeftContainer">
                    
                    

            <div class="row">
                
                

                <asp:Label ID="lblErrors" Visible="false" ForeColor="Red" runat="server" />
            </div>
            <div class="row" id="dvRightPanel" runat="server">            
                <div class="row">

                    <div class="col-md-4">
                        
                        

                        <div class="card border-color mb-3" style="width:20rem; height:15rem;border:solid;margin:30px 0px 0px 10px;">
                            <div class="card-body">
                                <div class="card-title" style="text-align:center;">
                                    <asp:Label Text="Server Utilization" runat="server" />
                                </div>
                                <div class="card-text" style="font-size:65px;text-align:center;">
                                    <asp:Label ID="txtServerUtilization" runat="server" Text="123" />
                                </div>
                            </div>

                        </div>

                    </div>
                    <div class="col-md-4">
                        <div class="card" style="width: 20rem; height: 15rem;border:solid;margin:30px 0px 0px 80px;">
                            <div class="card-body">
                                <div class="card-title" style="text-align:center;">
                                    <asp:Label Text="Server Idle" runat="server" />
                                </div>
                                <div class="card-text" style="font-size:65px;text-align:center;">
                                    <asp:Label ID="txtServerIdle" runat="server" />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="row">
                <div class="col-md-4">
                    <div class="card" style="width: 20rem; height: 15rem;border:solid;margin:30px 0px 0px 10px;">
                        <div class="card-body">
                            <div class="card-title" style="text-align:center;">
                                <asp:Label Text="Average System Wait " runat="server" />
                            </div>
                            <div class="card-text" style="font-size:65px;text-align:center;">
                                <asp:Label ID="txtAvgSystemWait" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card" style="width: 20rem; height: 15rem;border:solid;margin:30px 0px 0px 80px;">
                        <div class="card-body">
                            <div class="card-title" style="text-align:center;">
                                <asp:Label Text="Average Queue Wait" runat="server" />
                            </div>
                            <div class="card-text" style="font-size:65px;text-align:center;">
                                <asp:Label ID="txtAvgQueueWait" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                <div class="row">
                <div class="col-md-4">
                    <div class="card" style="width: 20rem; height: 15rem;border:solid;margin:30px 0px 0px 10px;;">
                        <div class="card-body">
                            <div class="card-title" style="text-align:center;">
                                <asp:Label Text="Average Length of System" runat="server" />
                            </div>
                            <div class="card-text" style="font-size:65px;text-align:center;">
                                <asp:Label ID="txtAvgLengthSys" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">

                    <div class="card" style="width: 20rem; height: 15rem;border:solid;margin:30px 0px 0px 80px;">
                        <div class="card-body">
                            <div class="card-title" style="text-align:center;">
                                <asp:Label Text="Average Length of Queue" runat="server" />
                            </div>
                            <div class="card-text" style="font-size:65px;text-align:center;">
                                <asp:Label ID="txtAvgLengthQueue" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>

                   
                </div>

                 

            </div>
        </div>
                
        </div>  
    

    </div>
</asp:Content>
