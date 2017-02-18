using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MaterialSkin.Controls;
using MaterialSkin;
using System.Windows.Forms;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.ComponentModel;
using System.Drawing.Text;
using Microsoft.CSharp;
using Microsoft.VisualBasic;

namespace MaisonDesLigues
{
    /// <summary>
    /// Classe "Boite à outil"
    /// </summary>
    public static class Helpers
    {
        public static Color FlatColor = Color.FromArgb(35, 168, 109);

        public static readonly StringFormat NearSF = new StringFormat
        {
            Alignment = StringAlignment.Near,
            LineAlignment = StringAlignment.Near
        };

        public static readonly StringFormat CenterSF = new StringFormat
        {
            Alignment = StringAlignment.Center,
            LineAlignment = StringAlignment.Center
        };

        public static GraphicsPath RoundRec(Rectangle Rectangle, int Curve)
        {
            GraphicsPath P = new GraphicsPath();
            int ArcRectangleWidth = Curve * 2;
            P.AddArc(new Rectangle(Rectangle.X, Rectangle.Y, ArcRectangleWidth, ArcRectangleWidth), -180, 90);
            P.AddArc(new Rectangle(Rectangle.Width - ArcRectangleWidth + Rectangle.X, Rectangle.Y, ArcRectangleWidth, ArcRectangleWidth), -90, 90);
            P.AddArc(new Rectangle(Rectangle.Width - ArcRectangleWidth + Rectangle.X, Rectangle.Height - ArcRectangleWidth + Rectangle.Y, ArcRectangleWidth, ArcRectangleWidth), 0, 90);
            P.AddArc(new Rectangle(Rectangle.X, Rectangle.Height - ArcRectangleWidth + Rectangle.Y, ArcRectangleWidth, ArcRectangleWidth), 90, 90);
            P.AddLine(new Point(Rectangle.X, Rectangle.Height - ArcRectangleWidth + Rectangle.Y), new Point(Rectangle.X, Curve + Rectangle.Y));
            return P;
        }

        public static GraphicsPath RoundRect(float x, float y, float w, float h, double r = 0.3,
            bool TL = true, bool TR = true, bool BR = true, bool BL = true)
        {
            GraphicsPath functionReturnValue = null;
            float d = Math.Min(w, h) * (float)r;
            float xw = x + w;
            float yh = y + h;
            functionReturnValue = new GraphicsPath();

            var _with1 = functionReturnValue;
            if (TL)
                _with1.AddArc(x, y, d, d, 180, 90);
            else
                _with1.AddLine(x, y, x, y);
            if (TR)
                _with1.AddArc(xw - d, y, d, d, 270, 90);
            else
                _with1.AddLine(xw, y, xw, y);
            if (BR)
                _with1.AddArc(xw - d, yh - d, d, d, 0, 90);
            else
                _with1.AddLine(xw, yh, xw, yh);
            if (BL)
                _with1.AddArc(x, yh - d, d, d, 90, 90);
            else
                _with1.AddLine(x, yh, x, yh);

            _with1.CloseFigure();
            return functionReturnValue;
        }

        //-- Credit: AeonHack
        public static GraphicsPath DrawArrow(int x, int y, bool flip)
        {
            GraphicsPath GP = new GraphicsPath();

            int W = 12;
            int H = 6;

            if (flip)
            {
                GP.AddLine(x + 1, y, x + W + 1, y);
                GP.AddLine(x + W, y, x + H, y + H - 1);
            }
            else
            {
                GP.AddLine(x, y + H, x + W, y + H);
                GP.AddLine(x + W, y + H, x + H, y);
            }

            GP.CloseFigure();
            return GP;
        }

        /// <summary>
        /// Get the colorscheme of a Control from a parent FormSkin.
        /// </summary>
        /// <param name="control">Control</param>
        /// <returns>Colors</returns>
        /// <exception cref="System.ArgumentNullException"></exception>
        public static FlatColors GetColors(Control control)
        {
            if (control == null)
                throw new ArgumentNullException();

            FlatColors colors = new FlatColors();

            while (control != null && (control.GetType() != typeof(FormSkin)))
            {
                control = control.Parent;
            }

            if (control != null)
            {
                FormSkin skin = (FormSkin)control;
                colors.Flat = skin.FlatColor;
            }

            return colors;
        }
    }

    enum MouseState : byte
    {
        None = 0,
        Over = 1,
        Down = 2,
        Block = 3
    }
    public class FormSkin : Control
    {
        private int W;
        private int H;
        private bool Cap = false;
        private bool _HeaderMaximize = false;
        private Point MousePoint = new Point(0, 0);
        private int MoveHeight = 50;

        [Category("Colors")]
        public Color HeaderColor
        {
            get { return _HeaderColor; }
            set { _HeaderColor = value; }
        }

        [Category("Colors")]
        public Color BaseColor
        {
            get { return _BaseColor; }
            set { _BaseColor = value; }
        }

        [Category("Colors")]
        public Color BorderColor
        {
            get { return _BorderColor; }
            set { _BorderColor = value; }
        }

        [Category("Colors")]
        public Color FlatColor
        {
            // get { return Helpers.FlatColor; }
            // set { Helpers.FlatColor = value; }
            get { return _FlatColor; }
            set { _FlatColor = value; }
        }

        [Category("Options")]
        public bool HeaderMaximize
        {
            get { return _HeaderMaximize; }
            set { _HeaderMaximize = value; }
        }

        protected override void OnMouseDown(MouseEventArgs e)
        {
            base.OnMouseDown(e);
            if (e.Button == System.Windows.Forms.MouseButtons.Left & new Rectangle(0, 0, Width, MoveHeight).Contains(e.Location))
            {
                Cap = true;
                MousePoint = e.Location;
            }
        }

        private void FormSkin_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (HeaderMaximize)
            {
                if (e.Button == System.Windows.Forms.MouseButtons.Left & new Rectangle(0, 0, Width, MoveHeight).Contains(e.Location))
                {
                    if (FindForm().WindowState == FormWindowState.Normal)
                    {
                        FindForm().WindowState = FormWindowState.Maximized;
                        FindForm().Refresh();
                    }
                    else if (FindForm().WindowState == FormWindowState.Maximized)
                    {
                        FindForm().WindowState = FormWindowState.Normal;
                        FindForm().Refresh();
                    }
                }
            }
        }

        protected override void OnMouseUp(MouseEventArgs e)
        {
            base.OnMouseUp(e);
            Cap = false;
        }

        protected override void OnMouseMove(MouseEventArgs e)
        {
            base.OnMouseMove(e);
            if (Cap)
            {
                // Parent.Location = MousePosition - MousePoint;
                Parent.Location = new Point(
                    MousePosition.X - MousePoint.X,
                    MousePosition.Y - MousePoint.Y
                );
            }
        }
        /*
        protected override void OnCreateControl()
        {
            base.OnCreateControl();
            ParentForm.FormBorderStyle = FormBorderStyle.None;
            ParentForm.AllowTransparency = false;
            ParentForm.TransparencyKey = Color.Fuchsia;
            ParentForm.FindForm().StartPosition = FormStartPosition.CenterScreen;
            Dock = DockStyle.Fill;
            Invalidate();
        }
        */
        private Color _HeaderColor = Color.FromArgb(45, 47, 49);
        private Color _BaseColor = Color.FromArgb(60, 70, 73);
        private Color _BorderColor = Color.FromArgb(53, 58, 60);
        private Color _FlatColor = Helpers.FlatColor;
        private Color TextColor = Color.FromArgb(234, 234, 234);

        private Color _HeaderLight = Color.FromArgb(171, 171, 172);
        private Color _BaseLight = Color.FromArgb(196, 199, 200);
        public Color TextLight = Color.FromArgb(45, 47, 49);

        public FormSkin()
        {
            MouseDoubleClick += FormSkin_MouseDoubleClick;
            SetStyle(ControlStyles.AllPaintingInWmPaint | ControlStyles.UserPaint | ControlStyles.ResizeRedraw | ControlStyles.OptimizedDoubleBuffer, true);
            DoubleBuffered = true;
            BackColor = Color.White;
            Font = new Font("Segoe UI", 12);
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            Bitmap B = new Bitmap(Width, Height);
            Graphics G = Graphics.FromImage(B);
            W = Width;
            H = Height;

            Rectangle Base = new Rectangle(0, 0, W, H);
            Rectangle Header = new Rectangle(0, 0, W, 50);

            var _with2 = G;
            _with2.SmoothingMode = SmoothingMode.HighQuality;
            _with2.PixelOffsetMode = PixelOffsetMode.HighQuality;
            _with2.TextRenderingHint = TextRenderingHint.ClearTypeGridFit;
            _with2.Clear(BackColor);

            //-- Base
            _with2.FillRectangle(new SolidBrush(_BaseColor), Base);

            //-- Header
            _with2.FillRectangle(new SolidBrush(_HeaderColor), Header);

            //-- Logo
            _with2.FillRectangle(new SolidBrush(Color.FromArgb(243, 243, 243)), new Rectangle(8, 16, 4, 18));
            _with2.FillRectangle(new SolidBrush(FlatColor), 16, 16, 4, 18);
            _with2.DrawString(Text, Font, new SolidBrush(TextColor), new Rectangle(26, 15, W, H), Helpers.NearSF);

            //-- Border
            _with2.DrawRectangle(new Pen(_BorderColor), Base);

            base.OnPaint(e);
            G.Dispose();
            e.Graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            e.Graphics.DrawImageUnscaled(B, 0, 0);
            B.Dispose();
        }
    }

    public class FlatColorPalette : Control
    {
        private int W;
        private int H;

        protected override void OnResize(EventArgs e)
        {
            base.OnResize(e);
            Width = 180;
            Height = 80;
        }

        [Category("Colors")]
        public Color Red
        {
            get { return _Red; }
            set { _Red = value; }
        }

        [Category("Colors")]
        public Color Cyan
        {
            get { return _Cyan; }
            set { _Cyan = value; }
        }

        [Category("Colors")]
        public Color Blue
        {
            get { return _Blue; }
            set { _Blue = value; }
        }

        [Category("Colors")]
        public Color LimeGreen
        {
            get { return _LimeGreen; }
            set { _LimeGreen = value; }
        }

        [Category("Colors")]
        public Color Orange
        {
            get { return _Orange; }
            set { _Orange = value; }
        }

        [Category("Colors")]
        public Color Purple
        {
            get { return _Purple; }
            set { _Purple = value; }
        }

        [Category("Colors")]
        public Color Black
        {
            get { return _Black; }
            set { _Black = value; }
        }

        [Category("Colors")]
        public Color Gray
        {
            get { return _Gray; }
            set { _Gray = value; }
        }

        [Category("Colors")]
        public Color White
        {
            get { return _White; }
            set { _White = value; }
        }

        private Color _Red = Color.FromArgb(220, 85, 96);
        private Color _Cyan = Color.FromArgb(10, 154, 157);
        private Color _Blue = Color.FromArgb(0, 128, 255);
        private Color _LimeGreen = Color.FromArgb(35, 168, 109);
        private Color _Orange = Color.FromArgb(253, 181, 63);
        private Color _Purple = Color.FromArgb(155, 88, 181);
        private Color _Black = Color.FromArgb(45, 47, 49);
        private Color _Gray = Color.FromArgb(63, 70, 73);
        private Color _White = Color.FromArgb(243, 243, 243);

        public FlatColorPalette()
        {
            SetStyle(ControlStyles.AllPaintingInWmPaint | ControlStyles.UserPaint | ControlStyles.ResizeRedraw | ControlStyles.OptimizedDoubleBuffer, true);
            DoubleBuffered = true;
            BackColor = Color.FromArgb(60, 70, 73);
            Size = new Size(160, 80);
            Font = new Font("Segoe UI", 12);
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            Bitmap B = new Bitmap(Width, Height);
            Graphics G = Graphics.FromImage(B);
            W = Width - 1;
            H = Height - 1;

            var _with6 = G;
            _with6.SmoothingMode = SmoothingMode.HighQuality;
            _with6.PixelOffsetMode = PixelOffsetMode.HighQuality;
            _with6.TextRenderingHint = TextRenderingHint.ClearTypeGridFit;
            _with6.Clear(BackColor);

            //-- Colors 
            _with6.FillRectangle(new SolidBrush(_Red), new Rectangle(0, 0, 20, 40));
            _with6.FillRectangle(new SolidBrush(_Cyan), new Rectangle(20, 0, 20, 40));
            _with6.FillRectangle(new SolidBrush(_Blue), new Rectangle(40, 0, 20, 40));
            _with6.FillRectangle(new SolidBrush(_LimeGreen), new Rectangle(60, 0, 20, 40));
            _with6.FillRectangle(new SolidBrush(_Orange), new Rectangle(80, 0, 20, 40));
            _with6.FillRectangle(new SolidBrush(_Purple), new Rectangle(100, 0, 20, 40));
            _with6.FillRectangle(new SolidBrush(_Black), new Rectangle(120, 0, 20, 40));
            _with6.FillRectangle(new SolidBrush(_Gray), new Rectangle(140, 0, 20, 40));
            _with6.FillRectangle(new SolidBrush(_White), new Rectangle(160, 0, 20, 40));

            //-- Text
            _with6.DrawString("Color Palette", Font, new SolidBrush(_White), new Rectangle(0, 22, W, H), Helpers.CenterSF);

            base.OnPaint(e);
            G.Dispose();
            e.Graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            e.Graphics.DrawImageUnscaled(B, 0, 0);
            B.Dispose();
        }
    }

    public class FlatColors
    {
        public Color Flat = Helpers.FlatColor;
    }



    public class FlatAlertBox : Control
    {
        /// <summary>
        /// How to use: FlatAlertBox.ShowControl(Kind, String, Interval)
        /// </summary>
        /// <remarks></remarks>

        private int W;
        private int H;
        private _Kind K;
        private string _Text;
        private MouseState State = MouseState.None;
        private int X;
        private Timer withEventsField_T;
        private Timer T
        {
            get { return withEventsField_T; }
            set
            {
                if (withEventsField_T != null)
                {
                    withEventsField_T.Tick -= T_Tick;
                }
                withEventsField_T = value;
                if (withEventsField_T != null)
                {
                    withEventsField_T.Tick += T_Tick;
                }
            }

        }



        [Flags()]
        public enum _Kind
        {
            Success,
            Error,
            Info
        }

        [Category("Options")]
        public _Kind kind
        {
            get { return K; }
            set { K = value; }
        }

        [Category("Options")]
        public override string Text
        {
            get { return base.Text; }
            set
            {
                base.Text = value;
                if (_Text != null)
                {
                    _Text = value;
                }
            }
        }

        [Category("Options")]
        public new bool Visible
        {
            get { return base.Visible == false; }
            set { base.Visible = value; }
        }

        protected override void OnTextChanged(EventArgs e)
        {
            base.OnTextChanged(e);
            Invalidate();
        }

        protected override void OnResize(EventArgs e)
        {
            base.OnResize(e);
            Height = 42;
        }

        public void ShowControl(_Kind Kind, string Str, int Interval)
        {
            
            K = Kind;
            Text = Str;
            // Ajout du fade In

            this.Visible = true;
            T = new Timer();
            T.Interval = Interval;
            T.Enabled = true;
        }

        private void T_Tick(object sender, EventArgs e)
        {
            this.Visible = false;
            T.Enabled = false;
            T.Dispose();
        }

        protected override void OnMouseDown(MouseEventArgs e)
        {
            base.OnMouseDown(e);
            State = MouseState.Down;
            Invalidate();
        }

        protected override void OnMouseUp(MouseEventArgs e)
        {
            base.OnMouseUp(e);
            State = MouseState.Over;
            Invalidate();
        }

        protected override void OnMouseEnter(EventArgs e)
        {
            base.OnMouseEnter(e);
            State = MouseState.Over;
            Invalidate();
        }

        protected override void OnMouseLeave(EventArgs e)
        {
            base.OnMouseLeave(e);
            State = MouseState.None;
            Invalidate();
        }

        protected override void OnMouseMove(MouseEventArgs e)
        {
            base.OnMouseMove(e);
            X = e.X;
            Invalidate();
        }

        protected override void OnClick(EventArgs e)
        {
            base.OnClick(e);
            this.Visible = false;
        }

        private Color SuccessColor = Color.FromArgb(60, 85, 79);
        private Color SuccessText = Color.FromArgb(35, 169, 110);
        private Color ErrorColor = Color.FromArgb(87, 71, 71);
        private Color ErrorText = Color.FromArgb(254, 142, 122);
        private Color InfoColor = Color.FromArgb(70, 91, 94);
        private Color InfoText = Color.FromArgb(97, 185, 186);

        public FlatAlertBox()
        {
            SetStyle(ControlStyles.AllPaintingInWmPaint | ControlStyles.UserPaint | ControlStyles.ResizeRedraw | ControlStyles.OptimizedDoubleBuffer | ControlStyles.SupportsTransparentBackColor, true);
            DoubleBuffered = true;
            BackColor = Color.FromArgb(60, 70, 73);
            Size = new Size(576, 42);
            Location = new Point(10, 61);
            Font = new Font("Segoe UI", 10);
            Cursor = Cursors.Hand;
        }

        protected override void OnPaint(PaintEventArgs e)
        {
            Bitmap B = new Bitmap(Width, Height);
            Graphics G = Graphics.FromImage(B);
            W = Width - 1;
            H = Height - 1;

            Rectangle Base = new Rectangle(0, 0, W, H);

            var _with14 = G;
            _with14.SmoothingMode = SmoothingMode.HighQuality;
            _with14.TextRenderingHint = TextRenderingHint.ClearTypeGridFit;
            _with14.Clear(BackColor);

            switch (K)
            {
                case _Kind.Success:
                    //-- Base
                    _with14.FillRectangle(new SolidBrush(SuccessColor), Base);

                    //-- Ellipse
                    _with14.FillEllipse(new SolidBrush(SuccessText), new Rectangle(8, 9, 24, 24));
                    _with14.FillEllipse(new SolidBrush(SuccessColor), new Rectangle(10, 11, 20, 20));

                    //-- Checked Sign
                    _with14.DrawString("ü", new Font("Wingdings", 22), new SolidBrush(SuccessText), new Rectangle(7, 7, W, H), Helpers.NearSF);
                    _with14.DrawString(Text, Font, new SolidBrush(SuccessText), new Rectangle(48, 12, W, H), Helpers.NearSF);

                    //-- X button
                    _with14.FillEllipse(new SolidBrush(Color.FromArgb(35, Color.Black)), new Rectangle(W - 30, H - 29, 17, 17));
                    _with14.DrawString("r", new Font("Marlett", 8), new SolidBrush(SuccessColor), new Rectangle(W - 28, 16, W, H), Helpers.NearSF);

                    switch (State)
                    {
                        // -- Mouse Over
                        case MouseState.Over:
                            _with14.DrawString("r", new Font("Marlett", 8), new SolidBrush(Color.FromArgb(25, Color.White)), new Rectangle(W - 28, 16, W, H), Helpers.NearSF);
                            break;
                    }

                    break;
                case _Kind.Error:
                    //-- Base
                    _with14.FillRectangle(new SolidBrush(ErrorColor), Base);

                    //-- Ellipse
                    _with14.FillEllipse(new SolidBrush(ErrorText), new Rectangle(8, 9, 24, 24));
                    _with14.FillEllipse(new SolidBrush(ErrorColor), new Rectangle(10, 11, 20, 20));

                    //-- X Sign
                    _with14.DrawString("r", new Font("Marlett", 16), new SolidBrush(ErrorText), new Rectangle(6, 11, W, H), Helpers.NearSF);
                    _with14.DrawString(Text, Font, new SolidBrush(ErrorText), new Rectangle(48, 12, W, H), Helpers.NearSF);

                    //-- X button
                    _with14.FillEllipse(new SolidBrush(Color.FromArgb(35, Color.Black)), new Rectangle(W - 32, H - 29, 17, 17));
                    _with14.DrawString("r", new Font("Marlett", 8), new SolidBrush(ErrorColor), new Rectangle(W - 30, 17, W, H), Helpers.NearSF);

                    switch (State)
                    {
                        case MouseState.Over:
                            // -- Mouse Over
                            _with14.DrawString("r", new Font("Marlett", 8), new SolidBrush(Color.FromArgb(25, Color.White)), new Rectangle(W - 30, 15, W, H), Helpers.NearSF);
                            break;
                    }

                    break;
                case _Kind.Info:
                    //-- Base
                    _with14.FillRectangle(new SolidBrush(InfoColor), Base);

                    //-- Ellipse
                    _with14.FillEllipse(new SolidBrush(InfoText), new Rectangle(8, 9, 24, 24));
                    _with14.FillEllipse(new SolidBrush(InfoColor), new Rectangle(10, 11, 20, 20));

                    //-- Info Sign
                    _with14.DrawString("¡", new Font("Segoe UI", 20, FontStyle.Bold), new SolidBrush(InfoText), new Rectangle(12, -4, W, H), Helpers.NearSF);
                    _with14.DrawString(Text, Font, new SolidBrush(InfoText), new Rectangle(48, 12, W, H), Helpers.NearSF);

                    //-- X button
                    _with14.FillEllipse(new SolidBrush(Color.FromArgb(35, Color.Black)), new Rectangle(W - 32, H - 29, 17, 17));
                    _with14.DrawString("r", new Font("Marlett", 8), new SolidBrush(InfoColor), new Rectangle(W - 30, 17, W, H), Helpers.NearSF);

                    switch (State)
                    {
                        case MouseState.Over:
                            // -- Mouse Over
                            _with14.DrawString("r", new Font("Marlett", 8), new SolidBrush(Color.FromArgb(25, Color.White)), new Rectangle(W - 30, 17, W, H), Helpers.NearSF);
                            break;
                    }
                    break;
            }

            base.OnPaint(e);
            G.Dispose();
            e.Graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            e.Graphics.DrawImageUnscaled(B, 0, 0);
            B.Dispose();
        }
    }

}


