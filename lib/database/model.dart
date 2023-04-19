import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

part 'model.g.dart';

const categoryTbl = SqfEntityTable(
  tableName: 'category_tbl',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  fields: [
    SqfEntityField(
        'title',
        DbType.text
    ),
    SqfEntityField(
        'sort',
        DbType.integer,
    )
  ]
);

const habitTbl = SqfEntityTable(
    tableName: 'habit_tbl',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    fields: [
        SqfEntityField(
            'title',
            DbType.text
        ),
        SqfEntityField(
            'mode',
            DbType.integer,
        ),
        SqfEntityField(
            'icon',
            DbType.text,
        ),
        SqfEntityField(
            'alarm',
            DbType.text,
        ),
        SqfEntityField(
            'presetTime',
            DbType.integer,
        ),
        SqfEntityField(
            'categoryIndex',
            DbType.integer,
        )
    ]
);

const pauseTbl = SqfEntityTable(
    tableName: 'pause_tbl',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    fields: [
        SqfEntityField(
            'startTime',
            DbType.integer,
        ),
        SqfEntityField(
            'endTime',
            DbType.integer,
        ),
        SqfEntityField(
            'stopwatchIndex',
            DbType.integer,
        )
    ]
);

const stopwatchTbl = SqfEntityTable(
    tableName: 'stopwatch_tbl',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    fields: [
        SqfEntityField(
            'startTime',
            DbType.integer,
        ),
        SqfEntityField(
            'endTime',
            DbType.integer,
        ),
        SqfEntityField(
            'habitIndex',
            DbType.integer,
        )
    ]
);

const seqIdentity = SqfEntitySequence(
    sequenceName: 'identity',
);

const _password = 'SPEND_TIME_DB_PASSWORD';

@SqfEntityBuilder(db)
const db = SqfEntityModel(
    modelName: 'SPEND_TIME',
    databaseName: 'spend_time_db.db',
    password: _password,
    databaseTables: [
        categoryTbl,
        habitTbl,
        pauseTbl,
        stopwatchTbl
    ],
    sequences: [seqIdentity],
    dbVersion: 4,
    bundledDatabasePath: null
);