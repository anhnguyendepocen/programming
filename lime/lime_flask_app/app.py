from wtforms import SubmitField, IntegerField
from wtforms.validators import InputRequired
from flask_wtf import FlaskForm
from flask_bootstrap import Bootstrap
from flask import Flask, render_template, session, redirect, url_for
from app_utils import bokeh_css_javascript, explain_plot


app = Flask(__name__)
app.config['SECRET_KEY'] = 'hard to guess string'
bootstrap = Bootstrap(app)


class NameForm(FlaskForm):
    """
    The end user will supply the input id to determine which
    observation to generate the explanation
    """
    input_id = IntegerField('Input ID', validators = [InputRequired()])
    submit = SubmitField('Submit')


@app.route('/', methods = ['GET', 'POST'])
def index():
    form = NameForm()
    if form.validate_on_submit():
        plot_script, plot_div = explain_plot(input_id = form.input_id.data)
        bokeh_css_files, bokeh_js_files = bokeh_css_javascript()
        session['plot_script'] = plot_script
        session['plot_div'] = plot_div
        session['bokeh_css_files'] = bokeh_css_files
        session['bokeh_js_files'] = bokeh_js_files
        return redirect(url_for('index'))

    return render_template(
        'index.html',
        form = form,
        plot_script = session.get('plot_script'),
        plot_div = session.get('plot_div'),
        bokeh_css_files = session.get('bokeh_css_files'),
        bokeh_js_files = session.get('bokeh_js_files'))


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


if __name__ == '__main__':
    app.run(debug = True)
