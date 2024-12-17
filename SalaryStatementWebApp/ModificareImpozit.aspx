<%@ Page Title="Modificare Impozit" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ModificareImpozit.aspx.cs" Inherits="SalaryStatementWebApp.ModificareImpozit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="password"] {
            width: 300px;
            padding: 8px;
            margin-bottom: 20px;
        }
        input[type="submit"] {
            padding: 10px 15px;
        }
        .error {
            color: red;
            font-size: 0.9em;
        }
        .valid {
            border-color: green;
        }
        .invalid {
            border-color: red;
        }
    </style>

    <h2>Modificare Impozit</h2>

    <label for="cas">CAS (%):</label>
    <asp:TextBox ID="cas" runat="server" onkeyup="validatePercentage(this)" />
    <div id="casError" class="error" style="display:none;"></div>

    <label for="cass">CASS (%):</label>
    <asp:TextBox ID="cass" runat="server" onkeyup="validatePercentage(this)" />
    <div id="cassError" class="error" style="display:none;"></div>

    <label for="impozit">Impozit (%):</label>
    <asp:TextBox ID="impozit" runat="server" onkeyup="validatePercentage(this)" />
    <div id="impozitError" class="error" style="display:none;"></div>

    <label for="parola">Parola:</label>
    <asp:TextBox ID="parola" runat="server" TextMode="Password" />

    <asp:Button ID="btnSubmit" runat="server" Text="Modificare" OnClick="btnSubmit_Click" />

    <div id="result" runat="server" style="color: red; margin-top: 20px;"></div>

    <script>
        function validatePercentage(input) {
            const value = input.value.trim(); // Trim whitespace
            const errorDivId = input.id + "Error";
            const errorDiv = document.getElementById(errorDivId);
            let isValid = true;
            let errorMessage = "";

            // Check for empty input
            if (value === "") {
                isValid = false;
                errorMessage = "Acest câmp nu poate fi gol.";
            }
            // Check if the value is a number (integer or decimal) and between 0 and 100
            else if (!/^\d+(\.\d+)?$/.test(value) || parseFloat(value) < 0 || parseFloat(value) > 100) {
                isValid = false;
                errorMessage = "Introduceti un numar valid între 0 si 100.";
            }

            // Show or hide the error message and set border color
            if (isValid) {
                errorDiv.style.display = "none";
                input.classList.remove("invalid");
                input.classList.add("valid");
            } else {
                errorDiv.style.display = "block";
                errorDiv.textContent = errorMessage;
                input.classList.remove("valid");
                input.classList.add("invalid");
            }

            // Check if all fields are valid and enable/disable the submit button accordingly
            validateAllFields();
        }

        function validateAllFields() {
            const casValid = validateField(document.getElementById('<%= cas.ClientID %>'));
            const cassValid = validateField(document.getElementById('<%= cass.ClientID %>'));
            const impozitValid = validateField(document.getElementById('<%= impozit.ClientID %>'));

            // Enable or disable the submit button based on overall validation
            const btnSubmit = document.getElementById('<%= btnSubmit.ClientID %>');
            btnSubmit.disabled = !(casValid && cassValid && impozitValid);
        }

        function validateField(input) {
            const value = input.value.trim();
            // Return true if it's a valid number between 0 and 100
            return /^\d+(\.\d+)?$/.test(value) && parseFloat(value) >= 0 && parseFloat(value) <= 100;
        }
    </script>
</asp:Content>
