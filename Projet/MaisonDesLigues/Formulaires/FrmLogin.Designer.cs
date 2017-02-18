namespace MaisonDesLigues
{
    partial class FrmLogin
    {
        /// <summary> 
        /// Required designer variable. 
        /// </summary> 
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used. 
        /// </summary> 
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param> 
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code 

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor. 
        /// </summary> 
        private void InitializeComponent()
        {
            this.TxtLogin = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.TxtMdp = new MaterialSkin.Controls.MaterialSingleLineTextField();
            this.chkSouvenirMdp = new MaterialSkin.Controls.MaterialCheckBox();
            this.CmdOk = new MaterialSkin.Controls.MaterialFlatButton();
            this.pictureBox3 = new System.Windows.Forms.PictureBox();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            this.SuspendLayout();
            // 
            // TxtLogin
            // 
            this.TxtLogin.Depth = 0;
            this.TxtLogin.Hint = "Nom d\'utilisateur";
            this.TxtLogin.Location = new System.Drawing.Point(63, 88);
            this.TxtLogin.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtLogin.Name = "TxtLogin";
            this.TxtLogin.PasswordChar = '\0';
            this.TxtLogin.SelectedText = "";
            this.TxtLogin.SelectionLength = 0;
            this.TxtLogin.SelectionStart = 0;
            this.TxtLogin.Size = new System.Drawing.Size(232, 23);
            this.TxtLogin.TabIndex = 0;
            this.TxtLogin.UseSystemPasswordChar = false;
            this.TxtLogin.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TxtMdp_KeyPress);
            // 
            // TxtMdp
            // 
            this.TxtMdp.Depth = 0;
            this.TxtMdp.Hint = "Mot de Passe";
            this.TxtMdp.Location = new System.Drawing.Point(63, 151);
            this.TxtMdp.MouseState = MaterialSkin.MouseState.HOVER;
            this.TxtMdp.Name = "TxtMdp";
            this.TxtMdp.PasswordChar = '\0';
            this.TxtMdp.SelectedText = "";
            this.TxtMdp.SelectionLength = 0;
            this.TxtMdp.SelectionStart = 0;
            this.TxtMdp.Size = new System.Drawing.Size(232, 23);
            this.TxtMdp.TabIndex = 1;
            this.TxtMdp.UseSystemPasswordChar = true;
            this.TxtMdp.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TxtMdp_KeyPress);
            // 
            // chkSouvenirMdp
            // 
            this.chkSouvenirMdp.AutoSize = true;
            this.chkSouvenirMdp.Depth = 0;
            this.chkSouvenirMdp.Font = new System.Drawing.Font("Roboto", 10F);
            this.chkSouvenirMdp.Location = new System.Drawing.Point(63, 187);
            this.chkSouvenirMdp.Margin = new System.Windows.Forms.Padding(0);
            this.chkSouvenirMdp.MouseLocation = new System.Drawing.Point(-1, -1);
            this.chkSouvenirMdp.MouseState = MaterialSkin.MouseState.HOVER;
            this.chkSouvenirMdp.Name = "chkSouvenirMdp";
            this.chkSouvenirMdp.Ripple = true;
            this.chkSouvenirMdp.Size = new System.Drawing.Size(198, 30);
            this.chkSouvenirMdp.TabIndex = 3;
            this.chkSouvenirMdp.Text = "Enregistrer le mot de passe";
            this.chkSouvenirMdp.UseVisualStyleBackColor = true;
            this.chkSouvenirMdp.CheckedChanged += new System.EventHandler(this.chkSouvenirMdp_CheckedChanged);
            // 
            // CmdOk
            // 
            this.CmdOk.AutoSize = true;
            this.CmdOk.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.CmdOk.Depth = 0;
            this.CmdOk.Location = new System.Drawing.Point(180, 235);
            this.CmdOk.Margin = new System.Windows.Forms.Padding(4, 6, 4, 6);
            this.CmdOk.MouseState = MaterialSkin.MouseState.HOVER;
            this.CmdOk.Name = "CmdOk";
            this.CmdOk.Primary = false;
            this.CmdOk.Size = new System.Drawing.Size(115, 36);
            this.CmdOk.TabIndex = 6;
            this.CmdOk.Text = "Identification";
            this.CmdOk.UseVisualStyleBackColor = true;
            this.CmdOk.Click += new System.EventHandler(this.CmdOk_Click);
            // 
            // pictureBox3
            // 
            this.pictureBox3.Image = global::MaisonDesLigues.Properties.Resources.Lock_32;
            this.pictureBox3.Location = new System.Drawing.Point(12, 146);
            this.pictureBox3.Name = "pictureBox3";
            this.pictureBox3.Size = new System.Drawing.Size(32, 32);
            this.pictureBox3.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox3.TabIndex = 4;
            this.pictureBox3.TabStop = false;
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = global::MaisonDesLigues.Properties.Resources.Contacts_Filled_32;
            this.pictureBox2.Location = new System.Drawing.Point(12, 83);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(32, 32);
            this.pictureBox2.TabIndex = 3;
            this.pictureBox2.TabStop = false;
            // 
            // FrmLogin
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(316, 290);
            this.Controls.Add(this.CmdOk);
            this.Controls.Add(this.chkSouvenirMdp);
            this.Controls.Add(this.pictureBox3);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.TxtMdp);
            this.Controls.Add(this.TxtLogin);
            this.MaximizeBox = false;
            this.Name = "FrmLogin";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Application Assises de l\'Escrime";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.FrmLogin_FormClosing);
            this.Load += new System.EventHandler(this.FrmLogin_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private MaterialSkin.Controls.MaterialSingleLineTextField TxtLogin;
        private MaterialSkin.Controls.MaterialSingleLineTextField TxtMdp;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.PictureBox pictureBox3;
        private MaterialSkin.Controls.MaterialCheckBox chkSouvenirMdp;
        private MaterialSkin.Controls.MaterialFlatButton CmdOk;

        private FlatAlertBox notif;
    }
}