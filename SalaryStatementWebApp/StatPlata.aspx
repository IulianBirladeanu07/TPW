<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatPlata.aspx.cs" Inherits="SalaryStatementWebApp.StatPlata" MasterPageFile="~/Site.Master" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Custom Styles -->
<style>
    /* Container to center content and give it margins */
    .container {
        width: 100%;
        max-width: 1500px;  /* Limit to 1200px width */
        margin: 0 auto;  /* Center horizontally */
        padding: 20px;
    }

    /* Container for centering the ReportViewer */
    .report-container {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;  /* Center horizontally */
        text-align: center;  /* Horizontally center the ReportViewer */
    }

    /* Optional: Style for the ReportViewer */
    #ReportViewer1 {
        width: 100%;  /* Ensure the report takes full width of its parent container */
        height: 800px;  /* Fixed height */
        margin: 0 auto;  /* Center the ReportViewer itself */
    }

    .btn, .label {
        margin-top: 15px;
        margin-bottom: 15px;
    }
</style>
    <div class="container">
        <h2>Stat de Plată</h2>
        
        <asp:Button ID="btnExportPDF" runat="server" Text="Exportă ca PDF" CssClass="btn btn-success" OnClick="btnExportPDF_Click" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

        <div class="report-container">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="800px" ProcessingMode="Local" />
        </div>
    </div>
</asp:Content>

