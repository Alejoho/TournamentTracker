using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TrackerLibrary;
using TrackerLibrary.Models;

namespace TrackerUI
{
    public partial class CreateTeamForm : Form
    {
        public CreateTeamForm()
        {
            InitializeComponent();
        }

        private void createMemberButton_Click(object sender, EventArgs e)
        {
            if(ValidateForm())
            {
                PersonModel model = new PersonModel();
                model.FirstName = firstNameValue.Text; 
                model.LastName=lastNameValue.Text;
                model.EmailAddress=emailValue.Text;
                model.CellphoneNumber=cellPhoneValue.Text;

                GlobalConfig.Connection.CreatePerson(model);

                ClearTextBoxesOfAddNewMember();
            }
            else
            {
                MessageBox.Show("This form has invalid information. Please check it and try again");
            }            
        }

        private bool ValidateForm()
        {
            bool output = true;

            if (firstNameValue.Text.Length == 0)
                output = false;

            if(lastNameValue.Text.Length == 0)
                output = false;

            if(emailValue.Text.Length == 0)
                output = false;

            if(cellPhoneValue.Text.Length == 0)
                output = false;

            return output;
        }

        private void ClearTextBoxesOfAddNewMember()
        {
            firstNameValue.Text = "";
            lastNameValue.Text = "";
            emailValue.Text = "";
            cellPhoneValue.Text = "";
        }

    }
}
