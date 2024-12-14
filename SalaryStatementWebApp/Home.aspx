<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SalaryStatementWebApp.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h1>Aplicația de Management a angajatilor</h1>
        
        <div class="overview-section">
            <h2>Ce poate face aplicația?</h2>
            <ul>
                <li><strong>Adăugare angajat:</strong> Permite adăugarea de noi angajați în sistem, completând detalii precum numele, salariul de bază, poziția, bonusurile, etc.</li>
                <li><strong>Actualizare informații angajați:</strong> Permite actualizarea informațiilor angajaților, cum ar fi salariul de bază, sporurile și bonusurile.</li>
                <li><strong>Calcularea salariilor:</strong> Salariile sunt calculate automat pe baza datelor de intrare și a procentajelor de taxă stocate în sistem.</li>
                <li><strong>Ștergere angajat:</strong> Permite ștergerea unui angajat din sistem pe baza unui criteriu de căutare (de exemplu, numele).</li>
                <li><strong>Generare fișă de plată:</strong> Permite generarea unui raport detaliat al salariului pentru fiecare angajat sau pentru toți angajații din companie.</li>
            </ul>
        </div>
    </div>
</asp:Content>