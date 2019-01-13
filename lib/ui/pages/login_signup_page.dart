import 'package:flutter/material.dart';
import 'package:closr/utils/auth.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginSignupPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();
  FormMode _formMode = FormMode.LOGIN;

  String _email;
  String _password;
  String _errorMessage;

  bool _isIos;
  bool _isLoading;
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width.toDouble();
    double padding = (width - 300) / 2;
    double logoSize = width / 2.5;

    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
        body: SafeArea(
      bottom: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _showCircularProgress(),
            _showBody(logoSize),
          ],
        ),
      ),
    ));
  }

  Widget _showLogo(logoSize) {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: logoSize,
        child: Image.asset(
          'asset/images/Closr_grey_01.png',
          color: Theme.of(context).primaryIconTheme.color,
        ),
      ),
    );
  }

  Widget _showEmailInput() {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        icon: Icon(Icons.mail, color: Colors.grey),
      ),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty,' : null,
      onSaved: (value) => _email = value,
    );
  }

  Widget _showPasswordInput() {
    return TextFormField(
      maxLines: 1,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(hintText: 'Password', icon: Icon(Icons.lock)),
      validator: (value) => value.isEmpty ? 'Password can\'t be empty,' : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget _showPrimaryButton() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 20,
        child: RaisedButton(
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Theme.of(context).buttonColor,
          child: _formMode == FormMode.LOGIN
              ? Text(
                  'Login',
                )
              : Text(
                  'Create Account',
                ),
          onPressed: _validateAndSubmit,
        ),
      ),
    );
  }

  Widget _showGoogleButton() {
    return RaisedButton(
      child: Text('Login with Google'),
      color: Theme.of(context).buttonColor,
      elevation: 7.0,
      onPressed: widget.auth.googleLogIn,
    );
  }

  Widget _showSecondaryButton() {
    return FlatButton(
      child: _formMode == FormMode.LOGIN
          ? Text('Create an account')
          : Text('Have an account? Sign in'),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(_errorMessage);
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showBody(logoSize) {
    return AccentColorOverride(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: _showLogo(logoSize),
              ),
              _showEmailInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              // _showGoogleButton(),
              _showErrorMessage()
            ],
          ),
        ),
      ),
    );
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(accentColor: color),
    );
  }
}
