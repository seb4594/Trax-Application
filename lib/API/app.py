from flask import Flask, request
from flask_restful import Api, Resource, reqparse, abort, marshal_with, fields
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
api = Api(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
db = SQLAlchemy(app)

class RecursiveTaskModel(db.Model):
    id = db.Column(db.String(10), primary_key=True)
    recurring = db.Column(db.String(20), nullable=False)
    date = db.Column(db.String(12), nullable=False)
    title = db.Column(db.String(30), nullable=False)
    device_id = db.Column(db.String(10), nullable=False)
    status = db.Column(db.String(30), nullable=False)
    start_time = db.Column(db.String(30), nullable=False)
    end_time = db.Column(db.String(20), nullable=False)

    def __repr__(self):
        return f'ID: {id}, Title: {title}, Device: {device_id}, Status: {status}, Start: {start_time}, End: {end_time}, recurring: {recurring}'


db.create_all()
rec_put_args = reqparse.RequestParser()
rec_put_args.add_argument('id', type=str, help='--Input id--', required=True)
rec_put_args.add_argument('recurring', type=str,
                          help='--Input recurring--', required=True)
rec_put_args.add_argument(
    'date', type=str, help='--Input Date--', required=True)
rec_put_args.add_argument(
    'title', type=str, help='--Input Title--', required=True)
rec_put_args.add_argument('device_id', type=str,
                          help='--Input Device ID--', required=True)
rec_put_args.add_argument('status', type=str,
                          help='--Input Status--', required=True)
rec_put_args.add_argument('start_time', type=str,
                          help='--Input Start Date--', required=True)
rec_put_args.add_argument('end_time', type=str,
                          help='--Input End Date--', required=True)
# patch args
rec_patch_args = reqparse.RequestParser()
rec_patch_args.add_argument('id', type=str, help='--Input id--')
rec_put_args.add_argument('recurring', type=str, help='--Input Recursion--')
rec_patch_args.add_argument('date', type=str, help='--Input Date--')
rec_patch_args.add_argument('title', type=str, help='--Input Title--')
rec_patch_args.add_argument('device_id', type=str, help='--Input Device ID--')
rec_patch_args.add_argument('status', type=str,  help='--Input Status--')
rec_patch_args.add_argument('start_time', type=str,
                            help='--Input Start Date--')
rec_patch_args.add_argument('end_time', type=str, help='--Input End Date--')


rec_resource_field = {
    'id': fields.String,
    'recurring': fields.String,
    'date': fields.String,
    'title': fields.String,
    'device_id': fields.String,
    'status': fields.String,
    'start_time': fields.String,
    'end_time': fields.String
}


get_args = reqparse.RequestParser()
get_args.add_argument('date', type=str, help='--Input Date--', required=True)



class RecursiveTask(Resource):
    @marshal_with(rec_resource_field)
    def get(self):
        args = get_args.parse_args()
        result = RecursiveTaskModel.query.filter_by(date=args['date']).all()
        return result

    @marshal_with(rec_resource_field)
    def put(self):
        args = rec_put_args.parse_args()
        ott = RecursiveTaskModel(id=args['id'], recurring=args['recurring'], date=args['date'], title=args['title'], device_id=args['device_id'],
                                 status=args['status'], start_time=args['start_time'], end_time=args['end_time'])
        db.session.add(ott)
        db.session.commit()

        return 201

    @marshal_with(rec_resource_field)
    def patch(self):
        args = rec_patch_args.parse_args()
        result = RecursiveTaskModel.query.filter_by(id=args['id']).first()

        if args['id']:
            result.id = args['id']
        if args['date']:
            result.date = args['date']
        if args['title']:
            result.title = args['title']
        if args['device_id']:
            result.device_id = args['device_id']
        if args['status']:
            result.status = args['status']
        if args['start_time']:
            result.start_time = args['start_time']
        if args['end_time']:
            result.end_time = args['end_time']
        # if args['recurring']:
        #     result.recurring = args['recurring']

        db.session.commit()
        return 201


api.add_resource(RecursiveTask, '/task/recursive')
if __name__ == '__main__':
    app.run(debug=True)
