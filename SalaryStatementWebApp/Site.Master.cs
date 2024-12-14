using System;

namespace SalaryStatementWebApp
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialize the clock when the page loads
            if (!IsPostBack)
            {
                UpdateTime();
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            UpdateTime(); // Update the time every tick
        }

        private void UpdateTime()
        {
            lblDateTime.Text = DateTime.Now.ToString("dd MMMM yyyy HH:mm:ss"); // Format as needed
        }
    }
}
