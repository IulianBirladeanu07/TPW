<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Calculator.aspx.cs" Inherits="SalaryStatementWebApp.Calculator" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Salary Calculator</h2>
    <table>
        <tr>
            <td>Name:</td>
            <td><asp:TextBox ID="txtName" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Function:</td>
            <td><asp:TextBox ID="txtFunction" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Base Salary:</td>
            <td><asp:TextBox ID="txtBaseSalary" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Bonus (%):</td>
            <td><asp:TextBox ID="txtBonus" runat="server" Text="0"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Premii Brute:</td>
            <td><asp:TextBox ID="txtPremiiBrute" runat="server" Text="0"></asp:TextBox></td>
        </tr>
        <tr>
            <td><asp:Button ID="btnCalculate" runat="server" Text="Calculate" OnClick="btnCalculate_Click" /></td>
        </tr>
    </table>
    <hr />
    <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="True"></asp:GridView>
</asp:Content>