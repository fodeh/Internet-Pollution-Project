<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SearchPage.aspx.vb" Inherits="WebApplication1.WebForm2" %>


<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            margin-left: 452px;
            margin-top: 4px;
        }
        .auto-style2 {
            margin-left: 344px;
        }
        .auto-style3 {
            margin-left: 569px;
        }
        .auto-style4 {
            margin-top: 0px;
        }
        .auto-style5 {
            height: 5889px;
        }
        .auto-style6 {
            margin-right: 13px;
        }
        </style>
    </head>
<body>
    <form id="form1" runat="server" style="background: #0094ff; clip: rect(auto, auto, 5000px, auto);" class="auto-style5">

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LocalServer %>" SelectCommand="SELECT [title], [link], [snippet] FROM [pollution_data]"></asp:SqlDataSource>

        <asp:HyperLink ID="Search_Link" runat="server" Visible="False">HyperLink</asp:HyperLink>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        &nbsp;
        <asp:Label ID="Title_Label" runat="server" CssClass="auto-style3" Font-Bold="True" Font-Size="Larger" Height="22px" Text="Custom Search" Width="138px" BackColor="White" BorderStyle="Solid"></asp:Label>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <br />
        <asp:TextBox ID="TextBox1" runat="server" BorderStyle="Outset" CssClass="auto-style2" Height="27px" Width="658px" BorderWidth="3px"></asp:TextBox>
        <br />
        <asp:Button ID="Search_Button" runat="server" CssClass="auto-style1" Height="42px" Text="Search" Width="420px" />
        <br />
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
        <asp:Label ID="Label1" runat="server" BorderStyle="None" Text="Start Date"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="EndDateLabel" runat="server" BorderStyle="None" Text="End Date"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="EndDateLabel0" runat="server" BorderStyle="None" Text="File Type"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
        <asp:Label ID="EndDateLabel1" runat="server" BorderStyle="None" Text="Safe Search"></asp:Label>
        <br />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:TextBox ID="StartDate" runat="server" CssClass="auto-style4" Height="16px" Width="107px" BorderWidth="3px">YYYY/MM/DD</asp:TextBox>
&nbsp;
        <asp:TextBox ID="EndDate" runat="server" CssClass="auto-style4" Height="16px" Width="107px" BorderWidth="3px">YYYY/MM/DD</asp:TextBox>
&nbsp;
        <asp:TextBox ID="fileType" runat="server" CssClass="auto-style4" Height="16px" Width="107px" BorderWidth="3px">.ex</asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:CheckBox ID="SafeCheck" runat="server" Text=" " BorderWidth="3px" />
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="1475px" Height="130px" ShowHeaderWhenEmpty="True" BackColor="#FFFFCC" DataSourceID="SqlDataSource1" Visible="False" BorderColor="Black" BorderStyle="Solid" BorderWidth="3px" CssClass="auto-style6">
            <Columns>
                <asp:BoundField DataField="title" HeaderText="Title" SortExpression="title" />
                <asp:hyperlinkfield DatatextField="link" HeaderText="Link" datanavigateurlfields="link" SortExpression="link" />
                <asp:BoundField DataField="snippet" HeaderText="Description" SortExpression="snippet" />
            </Columns>
        </asp:GridView>

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />       

    </form>
    </body>
</html>
