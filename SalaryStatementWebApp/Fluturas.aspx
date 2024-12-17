<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fluturas.aspx.cs" Inherits="SalaryStatementWebApp.Fluturas" MasterPageFile="~/Site.Master" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<!-- Custom CSS -->
<style>
    /* Container for centering */
    .container {
        width: 100%;
        max-width: 1200px;  /* Limit the maximum width of the container */
        margin: 0 auto;  /* Center the container horizontally */
        padding: 20px;
    }

    /* Create a container for the ReportViewer and center it */
    .report-container {
        width: 100%;  /* Make sure the container takes full width */
        max-width: 1200px;  /* Set a max width to avoid stretching the ReportViewer too much */
        margin: 0 auto;  /* Center the ReportViewer horizontally */
        text-align: center;  /* Horizontally center the ReportViewer */
    }

    /* Optional: If you want to apply some more styles to the ReportViewer itself */
    #ReportViewer1 {
        width: 100%;  /* Ensure it takes full width of its parent container */
        height: 700px;  /* Ensure height stays as defined */
        margin: 0 auto;  /* Ensure the ReportViewer itself is centered inside its container */
    }

    /* Optional: Style the button and label */
    .btn, .label {
        margin-top: 15px;
        margin-bottom: 15px;
    }
</style>

    <div class="container">
        <h2>Fluturas de Salar</h2>
        <asp:Button ID="btnExportPDF" runat="server" Text="Exportă ca PDF" CssClass="btn btn-success" OnClick="btnExportPDF_Click" />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <br /><br />
        
        <!-- Centered ReportViewer Container -->
        <div class="report-container">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" ProcessingMode="Local" Width="1200px" Height="700px">
            </rsweb:ReportViewer>
        </div>
    </div>
</asp:Content>
