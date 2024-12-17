<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActualizareAngajati.aspx.cs" Inherits="SalaryStatementWebApp.ActualizareAngajati" MasterPageFile="~/Site.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    /* General Body and Page Styling */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f7fb;
        margin: 0;
        padding: 0;
    }

    .form-container {
        max-width: 900px;
        margin: 40px auto;
        padding: 40px;
        border-radius: 12px;
        background-color: #ffffff;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        font-size: 16px;
        line-height: 1.6;
        border: 1px solid #e0e0e0;
    }

    /* Title Styling */
    h2 {
        font-size: 1.8rem;
        font-weight: bold;
        color: #333;
        text-align: center;
        margin-bottom: 30px;
    }

    .search-result h4 {
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 15px;
        color: #007bff;
    }

    /* Employee Item (Search Results) Styling */
    .employee-item {
        padding: 20px;
        margin-bottom: 20px;
        background-color: #f9fafb;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: all 0.3s ease;
    }

    .employee-item:hover {
        background-color: #f1f6fa;
        box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
    }

    .employee-item div {
        font-size: 1.1rem;
        color: #333;
    }

    .employee-item .btn {
        margin-left: 15px;
    }

    /* Edit Form Styling */
    .edit-form {
        margin-top: 30px;
        padding: 25px;
        border-top: 3px solid #007bff;
        border-radius: 8px;
        background-color: #f9fafb;
    }

    .edit-form h4 {
        font-size: 1.6rem;
        margin-bottom: 20px;
        color: #007bff;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        font-weight: 600;
        margin-bottom: 8px;
        display: block;
    }

    input[type="text"], input[type="number"], input[type="tel"], input[type="email"], input[type="password"] {
        width: 100%;
        padding: 12px;
        font-size: 1rem;
        border-radius: 6px;
        border: 1px solid #ccc;
        background-color: #f9f9f9;
        transition: border 0.3s ease;
    }

    input[type="text"]:focus, input[type="number"]:focus, input[type="tel"]:focus, input[type="email"]:focus, input[type="password"]:focus {
        outline: none;
        border-color: #007bff;
        background-color: #ffffff;
    }

    .input-invalid {
        border-color: #dc3545;
        background-color: #fff3f3;
    }

    .input-valid {
        border-color: #28a745;
        background-color: #e6f7e6;
    }

    .error-message {
        color: #dc3545;
        font-size: 0.875rem;
        margin-top: 5px;
    }

    .success-message {
        color: #28a745;
        font-size: 1.1rem;
        text-align: center;
        margin-top: 20px;
    }

    .button-group {
        display: flex;
        justify-content: space-between;
        gap: 15px;
    }

    .btn {
        padding: 12px 20px;
        font-size: 1.1rem;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 10px;
    }

    .btn:hover {
        opacity: 0.85;
    }

    .btn-success {
        background-color: #28a745;
        color: white;
    }

    .btn-success:hover {
        background-color: #218838;
    }

    .btn-warning {
        background-color: #ffc107;
        color: white;
    }

    .btn-warning:hover {
        background-color: #e0a800;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: white;
    }

    .btn-secondary:hover {
        background-color: #5a6268;
    }

    .btn-outline-secondary {
        background-color: transparent;
        border: 1px solid #ccc;
        color: #333;
    }

    .btn-outline-secondary:hover {
        background-color: #f1f1f1;
    }

    /* Responsive Design for smaller screens */
    @media (max-width: 768px) {
        .form-container {
            padding: 20px;
            max-width: 100%;
        }

        .employee-item {
            flex-direction: column;
            align-items: flex-start;
        }

        .button-group {
            flex-direction: column;
            align-items: flex-start;
        }
    }
</style>


    <div class="form-container">
        <h2 class="text-center">Actualizare Angajat</h2>
        
        <!-- Search Employee Section -->
        <div class="form-group">
            <label for="txtSearchName">Căutare Angajat (După Nume):</label>
            <div class="input-group mb-2">
                <asp:TextBox ID="txtSearchName" runat="server" placeholder="Introdu numele angajatului" CssClass="form-control" />

            </div>
            <asp:Button ID="btnSearchEmployee" runat="server" Text="Căutare" OnClick="btnSearchEmployee_Click" CssClass="btn btn-warning btn-sm" />
        </div>

        <!-- Hidden Field to store Employee ID -->
        <asp:HiddenField ID="hfEmployeeId" runat="server" />

        <!-- Display Search Results -->
        <div class="search-result mt-4">
            <h4>Rezultate Căutare:</h4>
            <asp:Repeater ID="rptEmployees" runat="server" OnItemCommand="rptEmployees_ItemCommand">
                <ItemTemplate>
                    <div class="employee-item">
                        <div>
                            <strong><%# Eval("Nume") %> <%# Eval("Prenume") %></strong><br />
                            Funcție: <%# Eval("Functie") %> - Salariu: <%# Eval("salar_baza") %>
                        </div>
                        <asp:Button 
                            ID="btnEditEmployee" 
                            runat="server" 
                            CommandName="EditEmployee" 
                            CommandArgument='<%# Eval("nr_crt") %>' 
                            Text="Editare" 
                            CssClass="btn btn-warning btn-sm" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Edit Employee Form -->
        <asp:Panel ID="editPanel" runat="server" CssClass="edit-form mt-4" Visible="false">
            <h4>Editare Angajat</h4>
            <div class="form-group">
                <label for="txtNume">Nume:</label>
                <asp:TextBox ID="txtNume" runat="server" placeholder="Introdu numele" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateName(this, 'Nume')" />
                <span id="errorNume" class="error-message"></span>
            </div>
            <div class="form-group">
                <label for="txtPrenume">Prenume:</label>
                <asp:TextBox ID="txtPrenume" runat="server" placeholder="Introdu prenumele" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateName(this, 'Prenume')" />
                <span id="errorPrenume" class="error-message"></span>
            </div>
            <div class="form-group">
                <label for="txtFunctie">Funcție:</label>
                <asp:TextBox ID="txtFunctie" runat="server" placeholder="Introdu funcția" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateFunctie(this)" />
                <span id="errorFunctie" class="error-message"></span>
            </div>
            <div class="form-group">
                <label for="txtSalarBaza">Salariul de bază:</label>
                <asp:TextBox ID="txtSalarBaza" runat="server" MaxLength="10" placeholder="Introdu salariul de bază" onkeypress="return isDecimalKey(event);" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateSalary(this)" />
                <span id="errorSalarBaza" class="error-message"></span>
            </div>
            <div class="form-group">
                <label for="txtSporPercent">Procentul de spor:</label>
                <asp:TextBox ID="txtSporPercent" runat="server" MaxLength="10" placeholder="Introdu procentul de spor" onkeypress="return isDecimalKey(event);" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateSporPercent(this)" />
                <span id="errorSporPercent" class="error-message"></span>
            </div>
            <div class="form-group">
                <label for="txtPremiiBrute">Premii brute:</label>
                <asp:TextBox ID="txtPremiiBrute" runat="server" MaxLength="10" placeholder="Introdu premiile brute" onkeypress="return isDecimalKey(event);" required="true" TextMode="SingleLine" CssClass="form-control" />
                <span id="errorPremiiBrute" class="error-message"></span>
            </div>
            <asp:Button ID="btnUpdateEmployee" runat="server" Text="Salvează" OnClick="btnUpdateEmployee_Click" CssClass="btn btn-success" />
            <asp:Button ID="btnCancelEdit" runat="server" Text="Anulează" OnClick="btnCancelEdit_Click" CssClass="btn btn-secondary" />
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger d-block mt-2" />
        </asp:Panel>
    </div>

    <script type="text/javascript">
        function isDecimalKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) {
                return false;
            }
            return true;
        }

        function validateName(input, field) {
            var nameRegex = /^[A-Z][a-zA-Zăâîșț]+$/;
            var errorMessage = field == "Nume" ? "Numele trebuie să înceapă cu literă mare și să conțină doar litere!" : "Prenumele trebuie să înceapă cu literă mare și să conțină doar litere!";
            var errorSpan = document.getElementById("error" + field);
            if (!input.value.match(nameRegex)) {
                input.classList.add("input-invalid");
                errorSpan.textContent = errorMessage;
            } else {
                input.classList.remove("input-invalid");
                input.classList.add("input-valid");
                errorSpan.textContent = "";
            }
        }

        function validateFunctie(input) {
            var errorSpan = document.getElementById("errorFunctie");
            if (input.value.trim() == "") {
                input.classList.add("input-invalid");
                errorSpan.textContent = "Funcția nu poate fi goală!";
            } else {
                input.classList.remove("input-invalid");
                input.classList.add("input-valid");
                errorSpan.textContent = "";
            }
        }

        function validateSalary(input) {
            var errorSpan = document.getElementById("errorSalarBaza");
            if (input.value <= 0) {
                input.classList.add("input-invalid");
                errorSpan.textContent = "Salariul de bază trebuie să fie mai mare decât 0!";
            } else {
                input.classList.remove("input-invalid");
                input.classList.add("input-valid");
                errorSpan.textContent = "";
            }
        }

        function validateSporPercent(input) {
            var errorSpan = document.getElementById("errorSporPercent");
            if (input.value < 0 || input.value > 100) {
                input.classList.add("input-invalid");
                errorSpan.textContent = "Procentul de spor trebuie să fie între 0 și 100!";
            } else {
                input.classList.remove("input-invalid");
                input.classList.add("input-valid");
                errorSpan.textContent = "";
            }
        }
    </script>
</asp:Content>
