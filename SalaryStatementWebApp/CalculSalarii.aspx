<%@ Page Title="Calcul Salarii" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CalculSalarii.aspx.cs" Inherits="SalaryStatementWebApp.CalculSalarii" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Form container for salary calculation -->
    <div class="form-container">
        <h2>Calcul Salarii</h2>

        <!-- Salariul de baza input -->
        <div class="form-group">
            <label for="txtSalarBaza">Salariul de bază:</label>
            <asp:TextBox ID="txtSalarBaza" runat="server" MaxLength="10" placeholder="Introdu salariul de bază" required="true" TextMode="SingleLine" CssClass="form-control" />
            <span id="errorSalarBaza" class="error-message"></span>
        </div>

        <!-- Procentul de spor input -->
        <div class="form-group">
            <label for="txtSporPercent">Procentul de spor:</label>
            <asp:TextBox ID="txtSporPercent" runat="server" MaxLength="10" placeholder="Introdu procentul de spor" required="true" TextMode="SingleLine" CssClass="form-control" />
            <span id="errorSporPercent" class="error-message"></span>
        </div>

        <!-- Premii brute input -->
        <div class="form-group">
            <label for="txtPremiiBrute">Premii brute:</label>
            <asp:TextBox ID="txtPremiiBrute" runat="server" MaxLength="10" placeholder="Introdu premiile brute" required="true" TextMode="SingleLine" CssClass="form-control" />
            <span id="errorPremiiBrute" class="error-message"></span>
        </div>

        <!-- Message Labels -->
        <div class="form-group">
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message" />
            <asp:Label ID="lblSuccessMessage" runat="server" CssClass="success-message" />
        </div>

        <hr />

        <!-- Calculate Button -->
        <div class="form-group">
            <asp:Button ID="btnCalculate" runat="server" Text="Calculează salariul" CssClass="btn btn-primary" OnClientClick="return validateForm();" OnClick="btnCalculate_Click" />
        </div>

        <!-- GridView to display results -->
        <div class="form-group table-responsive">
            <div style="overflow-x:auto;">
                <asp:GridView ID="gvResults" runat="server" AutoGenerateColumns="true" CssClass="table table-striped table-bordered" />
            </div>
            <div class="no-data" runat="server" visible="false">Nu există date pentru a fi afişate.</div>
        </div>
    </div>

    <!-- Custom Styles for the Page -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
        }

        .form-container {
            max-width: 650px;
            margin: 50px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #007bff;
            font-size: 28px;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 15px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
        }

        .form-group input::placeholder {
            font-style: italic;
            color: #aaa;
        }

        .form-group .error-message {
            color: red;
            font-size: 14px;
        }

        .form-group .success-message {
            color: green;
            font-size: 16px;
            text-align: center;
        }

        .form-group button {
            width: 100%;
            padding: 15px;
            font-size: 18px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-group button:hover {
            background-color: #0056b3;
        }

        .form-group button:active {
            background-color: #004085;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 30px;
                margin: 20px;
            }

            .form-container h2 {
                font-size: 24px;
            }

            .form-group input {
                font-size: 14px;
            }

            .form-group button {
                font-size: 16px;
            }
        }

        .table-responsive {
            margin-top: 30px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #007bff;
            color: white;
        }

        .table-striped tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        .table-bordered {
            border: 1px solid #ddd;
        }

        .no-data {
            text-align: center;
            font-size: 18px;
            color: #888;
            margin-top: 30px;
        }
    </style>

    <!-- Client-Side Validation Scripts -->
    <script>
        // Validation functions
        function validateSalarBaza() {
            var salarBaza = document.getElementById("txtSalarBaza").value;
            var errorSalarBaza = document.getElementById("errorSalarBaza");

            if (parseFloat(salarBaza) < 3700) {
                errorSalarBaza.textContent = "Salariul de bază trebuie să fie cel puțin 3700.";
                return false; // Invalid data
            } else {
                errorSalarBaza.textContent = ""; // Clear error message
                return true; // Valid data
            }
        }

        function validateSporPercent() {
            var sporPercent = document.getElementById("txtSporPercent").value;
            var errorSporPercent = document.getElementById("errorSporPercent");

            if (parseFloat(sporPercent) < 0 || parseFloat(sporPercent) > 100) {
                errorSporPercent.textContent = "Procentul de spor trebuie să fie între 0 și 100.";
                return false; // Invalid data
            } else {
                errorSporPercent.textContent = ""; // Clear error message
                return true; // Valid data
            }
        }

        function validatePremiiBrute() {
            var premiiBrute = document.getElementById("txtPremiiBrute").value;
            var errorPremiiBrute = document.getElementById("errorPremiiBrute");

            if (isNaN(premiiBrute) || parseFloat(premiiBrute) < 0) {
                errorPremiiBrute.textContent = "Premiile brute trebuie să fie un număr pozitiv.";
                return false;
            } else {
                errorPremiiBrute.textContent = "";
                return true;
            }
        }

        // Input event listeners to validate inputs live
        document.getElementById("txtSalarBaza").addEventListener("input", function () {
            validateSalarBaza();
        });
        document.getElementById("txtSporPercent").addEventListener("input", function () {
            validateSporPercent();
        });
        document.getElementById("txtPremiiBrute").addEventListener("input", function () {
            validatePremiiBrute();
        });

        // Function to handle form submission
        function validateForm() {
            var isSalarBazaValid = validateSalarBaza();
            var isSporPercentValid = validateSporPercent();
            var isPremiiBruteValid = validatePremiiBrute();

            return isSalarBazaValid && isSporPercentValid && isPremiiBruteValid;
        }
    </script>
</asp:Content>
