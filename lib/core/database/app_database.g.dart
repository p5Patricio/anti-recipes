// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bodyWeightKgMeta = const VerificationMeta(
    'bodyWeightKg',
  );
  @override
  late final GeneratedColumn<double> bodyWeightKg = GeneratedColumn<double>(
    'body_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinGPerDayMeta = const VerificationMeta(
    'proteinGPerDay',
  );
  @override
  late final GeneratedColumn<double> proteinGPerDay = GeneratedColumn<double>(
    'protein_g_per_day',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatGPerDayMeta = const VerificationMeta(
    'fatGPerDay',
  );
  @override
  late final GeneratedColumn<double> fatGPerDay = GeneratedColumn<double>(
    'fat_g_per_day',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealsPerDayMeta = const VerificationMeta(
    'mealsPerDay',
  );
  @override
  late final GeneratedColumn<int> mealsPerDay = GeneratedColumn<int>(
    'meals_per_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinPerMealMinMeta = const VerificationMeta(
    'proteinPerMealMin',
  );
  @override
  late final GeneratedColumn<double> proteinPerMealMin =
      GeneratedColumn<double>(
        'protein_per_meal_min',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _proteinPerMealMaxMeta = const VerificationMeta(
    'proteinPerMealMax',
  );
  @override
  late final GeneratedColumn<double> proteinPerMealMax =
      GeneratedColumn<double>(
        'protein_per_meal_max',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bodyWeightKg,
    proteinGPerDay,
    fatGPerDay,
    mealsPerDay,
    proteinPerMealMin,
    proteinPerMealMax,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('body_weight_kg')) {
      context.handle(
        _bodyWeightKgMeta,
        bodyWeightKg.isAcceptableOrUnknown(
          data['body_weight_kg']!,
          _bodyWeightKgMeta,
        ),
      );
    }
    if (data.containsKey('protein_g_per_day')) {
      context.handle(
        _proteinGPerDayMeta,
        proteinGPerDay.isAcceptableOrUnknown(
          data['protein_g_per_day']!,
          _proteinGPerDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinGPerDayMeta);
    }
    if (data.containsKey('fat_g_per_day')) {
      context.handle(
        _fatGPerDayMeta,
        fatGPerDay.isAcceptableOrUnknown(
          data['fat_g_per_day']!,
          _fatGPerDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fatGPerDayMeta);
    }
    if (data.containsKey('meals_per_day')) {
      context.handle(
        _mealsPerDayMeta,
        mealsPerDay.isAcceptableOrUnknown(
          data['meals_per_day']!,
          _mealsPerDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mealsPerDayMeta);
    }
    if (data.containsKey('protein_per_meal_min')) {
      context.handle(
        _proteinPerMealMinMeta,
        proteinPerMealMin.isAcceptableOrUnknown(
          data['protein_per_meal_min']!,
          _proteinPerMealMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPerMealMinMeta);
    }
    if (data.containsKey('protein_per_meal_max')) {
      context.handle(
        _proteinPerMealMaxMeta,
        proteinPerMealMax.isAcceptableOrUnknown(
          data['protein_per_meal_max']!,
          _proteinPerMealMaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPerMealMaxMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bodyWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_weight_kg'],
      ),
      proteinGPerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g_per_day'],
      )!,
      fatGPerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g_per_day'],
      )!,
      mealsPerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meals_per_day'],
      )!,
      proteinPerMealMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per_meal_min'],
      )!,
      proteinPerMealMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per_meal_max'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final double? bodyWeightKg;
  final double proteinGPerDay;
  final double fatGPerDay;
  final int mealsPerDay;
  final double proteinPerMealMin;
  final double proteinPerMealMax;
  const UserProfile({
    required this.id,
    this.bodyWeightKg,
    required this.proteinGPerDay,
    required this.fatGPerDay,
    required this.mealsPerDay,
    required this.proteinPerMealMin,
    required this.proteinPerMealMax,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || bodyWeightKg != null) {
      map['body_weight_kg'] = Variable<double>(bodyWeightKg);
    }
    map['protein_g_per_day'] = Variable<double>(proteinGPerDay);
    map['fat_g_per_day'] = Variable<double>(fatGPerDay);
    map['meals_per_day'] = Variable<int>(mealsPerDay);
    map['protein_per_meal_min'] = Variable<double>(proteinPerMealMin);
    map['protein_per_meal_max'] = Variable<double>(proteinPerMealMax);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      bodyWeightKg: bodyWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyWeightKg),
      proteinGPerDay: Value(proteinGPerDay),
      fatGPerDay: Value(fatGPerDay),
      mealsPerDay: Value(mealsPerDay),
      proteinPerMealMin: Value(proteinPerMealMin),
      proteinPerMealMax: Value(proteinPerMealMax),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      bodyWeightKg: serializer.fromJson<double?>(json['bodyWeightKg']),
      proteinGPerDay: serializer.fromJson<double>(json['proteinGPerDay']),
      fatGPerDay: serializer.fromJson<double>(json['fatGPerDay']),
      mealsPerDay: serializer.fromJson<int>(json['mealsPerDay']),
      proteinPerMealMin: serializer.fromJson<double>(json['proteinPerMealMin']),
      proteinPerMealMax: serializer.fromJson<double>(json['proteinPerMealMax']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bodyWeightKg': serializer.toJson<double?>(bodyWeightKg),
      'proteinGPerDay': serializer.toJson<double>(proteinGPerDay),
      'fatGPerDay': serializer.toJson<double>(fatGPerDay),
      'mealsPerDay': serializer.toJson<int>(mealsPerDay),
      'proteinPerMealMin': serializer.toJson<double>(proteinPerMealMin),
      'proteinPerMealMax': serializer.toJson<double>(proteinPerMealMax),
    };
  }

  UserProfile copyWith({
    int? id,
    Value<double?> bodyWeightKg = const Value.absent(),
    double? proteinGPerDay,
    double? fatGPerDay,
    int? mealsPerDay,
    double? proteinPerMealMin,
    double? proteinPerMealMax,
  }) => UserProfile(
    id: id ?? this.id,
    bodyWeightKg: bodyWeightKg.present ? bodyWeightKg.value : this.bodyWeightKg,
    proteinGPerDay: proteinGPerDay ?? this.proteinGPerDay,
    fatGPerDay: fatGPerDay ?? this.fatGPerDay,
    mealsPerDay: mealsPerDay ?? this.mealsPerDay,
    proteinPerMealMin: proteinPerMealMin ?? this.proteinPerMealMin,
    proteinPerMealMax: proteinPerMealMax ?? this.proteinPerMealMax,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      bodyWeightKg: data.bodyWeightKg.present
          ? data.bodyWeightKg.value
          : this.bodyWeightKg,
      proteinGPerDay: data.proteinGPerDay.present
          ? data.proteinGPerDay.value
          : this.proteinGPerDay,
      fatGPerDay: data.fatGPerDay.present
          ? data.fatGPerDay.value
          : this.fatGPerDay,
      mealsPerDay: data.mealsPerDay.present
          ? data.mealsPerDay.value
          : this.mealsPerDay,
      proteinPerMealMin: data.proteinPerMealMin.present
          ? data.proteinPerMealMin.value
          : this.proteinPerMealMin,
      proteinPerMealMax: data.proteinPerMealMax.present
          ? data.proteinPerMealMax.value
          : this.proteinPerMealMax,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('bodyWeightKg: $bodyWeightKg, ')
          ..write('proteinGPerDay: $proteinGPerDay, ')
          ..write('fatGPerDay: $fatGPerDay, ')
          ..write('mealsPerDay: $mealsPerDay, ')
          ..write('proteinPerMealMin: $proteinPerMealMin, ')
          ..write('proteinPerMealMax: $proteinPerMealMax')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bodyWeightKg,
    proteinGPerDay,
    fatGPerDay,
    mealsPerDay,
    proteinPerMealMin,
    proteinPerMealMax,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.bodyWeightKg == this.bodyWeightKg &&
          other.proteinGPerDay == this.proteinGPerDay &&
          other.fatGPerDay == this.fatGPerDay &&
          other.mealsPerDay == this.mealsPerDay &&
          other.proteinPerMealMin == this.proteinPerMealMin &&
          other.proteinPerMealMax == this.proteinPerMealMax);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<double?> bodyWeightKg;
  final Value<double> proteinGPerDay;
  final Value<double> fatGPerDay;
  final Value<int> mealsPerDay;
  final Value<double> proteinPerMealMin;
  final Value<double> proteinPerMealMax;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.bodyWeightKg = const Value.absent(),
    this.proteinGPerDay = const Value.absent(),
    this.fatGPerDay = const Value.absent(),
    this.mealsPerDay = const Value.absent(),
    this.proteinPerMealMin = const Value.absent(),
    this.proteinPerMealMax = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.bodyWeightKg = const Value.absent(),
    required double proteinGPerDay,
    required double fatGPerDay,
    required int mealsPerDay,
    required double proteinPerMealMin,
    required double proteinPerMealMax,
  }) : proteinGPerDay = Value(proteinGPerDay),
       fatGPerDay = Value(fatGPerDay),
       mealsPerDay = Value(mealsPerDay),
       proteinPerMealMin = Value(proteinPerMealMin),
       proteinPerMealMax = Value(proteinPerMealMax);
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<double>? bodyWeightKg,
    Expression<double>? proteinGPerDay,
    Expression<double>? fatGPerDay,
    Expression<int>? mealsPerDay,
    Expression<double>? proteinPerMealMin,
    Expression<double>? proteinPerMealMax,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bodyWeightKg != null) 'body_weight_kg': bodyWeightKg,
      if (proteinGPerDay != null) 'protein_g_per_day': proteinGPerDay,
      if (fatGPerDay != null) 'fat_g_per_day': fatGPerDay,
      if (mealsPerDay != null) 'meals_per_day': mealsPerDay,
      if (proteinPerMealMin != null) 'protein_per_meal_min': proteinPerMealMin,
      if (proteinPerMealMax != null) 'protein_per_meal_max': proteinPerMealMax,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<double?>? bodyWeightKg,
    Value<double>? proteinGPerDay,
    Value<double>? fatGPerDay,
    Value<int>? mealsPerDay,
    Value<double>? proteinPerMealMin,
    Value<double>? proteinPerMealMax,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      bodyWeightKg: bodyWeightKg ?? this.bodyWeightKg,
      proteinGPerDay: proteinGPerDay ?? this.proteinGPerDay,
      fatGPerDay: fatGPerDay ?? this.fatGPerDay,
      mealsPerDay: mealsPerDay ?? this.mealsPerDay,
      proteinPerMealMin: proteinPerMealMin ?? this.proteinPerMealMin,
      proteinPerMealMax: proteinPerMealMax ?? this.proteinPerMealMax,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bodyWeightKg.present) {
      map['body_weight_kg'] = Variable<double>(bodyWeightKg.value);
    }
    if (proteinGPerDay.present) {
      map['protein_g_per_day'] = Variable<double>(proteinGPerDay.value);
    }
    if (fatGPerDay.present) {
      map['fat_g_per_day'] = Variable<double>(fatGPerDay.value);
    }
    if (mealsPerDay.present) {
      map['meals_per_day'] = Variable<int>(mealsPerDay.value);
    }
    if (proteinPerMealMin.present) {
      map['protein_per_meal_min'] = Variable<double>(proteinPerMealMin.value);
    }
    if (proteinPerMealMax.present) {
      map['protein_per_meal_max'] = Variable<double>(proteinPerMealMax.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('bodyWeightKg: $bodyWeightKg, ')
          ..write('proteinGPerDay: $proteinGPerDay, ')
          ..write('fatGPerDay: $fatGPerDay, ')
          ..write('mealsPerDay: $mealsPerDay, ')
          ..write('proteinPerMealMin: $proteinPerMealMin, ')
          ..write('proteinPerMealMax: $proteinPerMealMax')
          ..write(')'))
        .toString();
  }
}

class $DayTypeTargetRowsTable extends DayTypeTargetRows
    with TableInfo<$DayTypeTargetRowsTable, DayTypeTargetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayTypeTargetRowsTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<DayType, String> dayType =
      GeneratedColumn<String>(
        'day_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DayType>($DayTypeTargetRowsTable.$converterdayType);
  static const VerificationMeta _kcalMinMeta = const VerificationMeta(
    'kcalMin',
  );
  @override
  late final GeneratedColumn<double> kcalMin = GeneratedColumn<double>(
    'kcal_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kcalMaxMeta = const VerificationMeta(
    'kcalMax',
  );
  @override
  late final GeneratedColumn<double> kcalMax = GeneratedColumn<double>(
    'kcal_max',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsMinMeta = const VerificationMeta(
    'carbsMin',
  );
  @override
  late final GeneratedColumn<double> carbsMin = GeneratedColumn<double>(
    'carbs_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsMaxMeta = const VerificationMeta(
    'carbsMax',
  );
  @override
  late final GeneratedColumn<double> carbsMax = GeneratedColumn<double>(
    'carbs_max',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fiberMinMeta = const VerificationMeta(
    'fiberMin',
  );
  @override
  late final GeneratedColumn<double> fiberMin = GeneratedColumn<double>(
    'fiber_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fiberMaxMeta = const VerificationMeta(
    'fiberMax',
  );
  @override
  late final GeneratedColumn<double> fiberMax = GeneratedColumn<double>(
    'fiber_max',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterMlMinMeta = const VerificationMeta(
    'waterMlMin',
  );
  @override
  late final GeneratedColumn<double> waterMlMin = GeneratedColumn<double>(
    'water_ml_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterMlMaxMeta = const VerificationMeta(
    'waterMlMax',
  );
  @override
  late final GeneratedColumn<double> waterMlMax = GeneratedColumn<double>(
    'water_ml_max',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fruitMinMeta = const VerificationMeta(
    'fruitMin',
  );
  @override
  late final GeneratedColumn<double> fruitMin = GeneratedColumn<double>(
    'fruit_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fruitMaxMeta = const VerificationMeta(
    'fruitMax',
  );
  @override
  late final GeneratedColumn<double> fruitMax = GeneratedColumn<double>(
    'fruit_max',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vegMinMeta = const VerificationMeta('vegMin');
  @override
  late final GeneratedColumn<double> vegMin = GeneratedColumn<double>(
    'veg_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vegMaxMeta = const VerificationMeta('vegMax');
  @override
  late final GeneratedColumn<double> vegMax = GeneratedColumn<double>(
    'veg_max',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    dayType,
    kcalMin,
    kcalMax,
    carbsMin,
    carbsMax,
    fiberMin,
    fiberMax,
    waterMlMin,
    waterMlMax,
    fruitMin,
    fruitMax,
    vegMin,
    vegMax,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_type_target_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayTypeTargetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kcal_min')) {
      context.handle(
        _kcalMinMeta,
        kcalMin.isAcceptableOrUnknown(data['kcal_min']!, _kcalMinMeta),
      );
    } else if (isInserting) {
      context.missing(_kcalMinMeta);
    }
    if (data.containsKey('kcal_max')) {
      context.handle(
        _kcalMaxMeta,
        kcalMax.isAcceptableOrUnknown(data['kcal_max']!, _kcalMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_kcalMaxMeta);
    }
    if (data.containsKey('carbs_min')) {
      context.handle(
        _carbsMinMeta,
        carbsMin.isAcceptableOrUnknown(data['carbs_min']!, _carbsMinMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsMinMeta);
    }
    if (data.containsKey('carbs_max')) {
      context.handle(
        _carbsMaxMeta,
        carbsMax.isAcceptableOrUnknown(data['carbs_max']!, _carbsMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsMaxMeta);
    }
    if (data.containsKey('fiber_min')) {
      context.handle(
        _fiberMinMeta,
        fiberMin.isAcceptableOrUnknown(data['fiber_min']!, _fiberMinMeta),
      );
    } else if (isInserting) {
      context.missing(_fiberMinMeta);
    }
    if (data.containsKey('fiber_max')) {
      context.handle(
        _fiberMaxMeta,
        fiberMax.isAcceptableOrUnknown(data['fiber_max']!, _fiberMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_fiberMaxMeta);
    }
    if (data.containsKey('water_ml_min')) {
      context.handle(
        _waterMlMinMeta,
        waterMlMin.isAcceptableOrUnknown(
          data['water_ml_min']!,
          _waterMlMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_waterMlMinMeta);
    }
    if (data.containsKey('water_ml_max')) {
      context.handle(
        _waterMlMaxMeta,
        waterMlMax.isAcceptableOrUnknown(
          data['water_ml_max']!,
          _waterMlMaxMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_waterMlMaxMeta);
    }
    if (data.containsKey('fruit_min')) {
      context.handle(
        _fruitMinMeta,
        fruitMin.isAcceptableOrUnknown(data['fruit_min']!, _fruitMinMeta),
      );
    } else if (isInserting) {
      context.missing(_fruitMinMeta);
    }
    if (data.containsKey('fruit_max')) {
      context.handle(
        _fruitMaxMeta,
        fruitMax.isAcceptableOrUnknown(data['fruit_max']!, _fruitMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_fruitMaxMeta);
    }
    if (data.containsKey('veg_min')) {
      context.handle(
        _vegMinMeta,
        vegMin.isAcceptableOrUnknown(data['veg_min']!, _vegMinMeta),
      );
    } else if (isInserting) {
      context.missing(_vegMinMeta);
    }
    if (data.containsKey('veg_max')) {
      context.handle(
        _vegMaxMeta,
        vegMax.isAcceptableOrUnknown(data['veg_max']!, _vegMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_vegMaxMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dayType};
  @override
  DayTypeTargetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayTypeTargetRow(
      dayType: $DayTypeTargetRowsTable.$converterdayType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}day_type'],
        )!,
      ),
      kcalMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_min'],
      )!,
      kcalMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal_max'],
      )!,
      carbsMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_min'],
      )!,
      carbsMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_max'],
      )!,
      fiberMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber_min'],
      )!,
      fiberMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber_max'],
      )!,
      waterMlMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_ml_min'],
      )!,
      waterMlMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_ml_max'],
      )!,
      fruitMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fruit_min'],
      )!,
      fruitMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fruit_max'],
      )!,
      vegMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}veg_min'],
      )!,
      vegMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}veg_max'],
      )!,
    );
  }

  @override
  $DayTypeTargetRowsTable createAlias(String alias) {
    return $DayTypeTargetRowsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DayType, String, String> $converterdayType =
      const EnumNameConverter<DayType>(DayType.values);
}

class DayTypeTargetRow extends DataClass
    implements Insertable<DayTypeTargetRow> {
  final DayType dayType;
  final double kcalMin;
  final double kcalMax;
  final double carbsMin;
  final double carbsMax;
  final double fiberMin;
  final double fiberMax;
  final double waterMlMin;
  final double waterMlMax;
  final double fruitMin;
  final double fruitMax;
  final double vegMin;
  final double vegMax;
  const DayTypeTargetRow({
    required this.dayType,
    required this.kcalMin,
    required this.kcalMax,
    required this.carbsMin,
    required this.carbsMax,
    required this.fiberMin,
    required this.fiberMax,
    required this.waterMlMin,
    required this.waterMlMax,
    required this.fruitMin,
    required this.fruitMax,
    required this.vegMin,
    required this.vegMax,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['day_type'] = Variable<String>(
        $DayTypeTargetRowsTable.$converterdayType.toSql(dayType),
      );
    }
    map['kcal_min'] = Variable<double>(kcalMin);
    map['kcal_max'] = Variable<double>(kcalMax);
    map['carbs_min'] = Variable<double>(carbsMin);
    map['carbs_max'] = Variable<double>(carbsMax);
    map['fiber_min'] = Variable<double>(fiberMin);
    map['fiber_max'] = Variable<double>(fiberMax);
    map['water_ml_min'] = Variable<double>(waterMlMin);
    map['water_ml_max'] = Variable<double>(waterMlMax);
    map['fruit_min'] = Variable<double>(fruitMin);
    map['fruit_max'] = Variable<double>(fruitMax);
    map['veg_min'] = Variable<double>(vegMin);
    map['veg_max'] = Variable<double>(vegMax);
    return map;
  }

  DayTypeTargetRowsCompanion toCompanion(bool nullToAbsent) {
    return DayTypeTargetRowsCompanion(
      dayType: Value(dayType),
      kcalMin: Value(kcalMin),
      kcalMax: Value(kcalMax),
      carbsMin: Value(carbsMin),
      carbsMax: Value(carbsMax),
      fiberMin: Value(fiberMin),
      fiberMax: Value(fiberMax),
      waterMlMin: Value(waterMlMin),
      waterMlMax: Value(waterMlMax),
      fruitMin: Value(fruitMin),
      fruitMax: Value(fruitMax),
      vegMin: Value(vegMin),
      vegMax: Value(vegMax),
    );
  }

  factory DayTypeTargetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayTypeTargetRow(
      dayType: $DayTypeTargetRowsTable.$converterdayType.fromJson(
        serializer.fromJson<String>(json['dayType']),
      ),
      kcalMin: serializer.fromJson<double>(json['kcalMin']),
      kcalMax: serializer.fromJson<double>(json['kcalMax']),
      carbsMin: serializer.fromJson<double>(json['carbsMin']),
      carbsMax: serializer.fromJson<double>(json['carbsMax']),
      fiberMin: serializer.fromJson<double>(json['fiberMin']),
      fiberMax: serializer.fromJson<double>(json['fiberMax']),
      waterMlMin: serializer.fromJson<double>(json['waterMlMin']),
      waterMlMax: serializer.fromJson<double>(json['waterMlMax']),
      fruitMin: serializer.fromJson<double>(json['fruitMin']),
      fruitMax: serializer.fromJson<double>(json['fruitMax']),
      vegMin: serializer.fromJson<double>(json['vegMin']),
      vegMax: serializer.fromJson<double>(json['vegMax']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dayType': serializer.toJson<String>(
        $DayTypeTargetRowsTable.$converterdayType.toJson(dayType),
      ),
      'kcalMin': serializer.toJson<double>(kcalMin),
      'kcalMax': serializer.toJson<double>(kcalMax),
      'carbsMin': serializer.toJson<double>(carbsMin),
      'carbsMax': serializer.toJson<double>(carbsMax),
      'fiberMin': serializer.toJson<double>(fiberMin),
      'fiberMax': serializer.toJson<double>(fiberMax),
      'waterMlMin': serializer.toJson<double>(waterMlMin),
      'waterMlMax': serializer.toJson<double>(waterMlMax),
      'fruitMin': serializer.toJson<double>(fruitMin),
      'fruitMax': serializer.toJson<double>(fruitMax),
      'vegMin': serializer.toJson<double>(vegMin),
      'vegMax': serializer.toJson<double>(vegMax),
    };
  }

  DayTypeTargetRow copyWith({
    DayType? dayType,
    double? kcalMin,
    double? kcalMax,
    double? carbsMin,
    double? carbsMax,
    double? fiberMin,
    double? fiberMax,
    double? waterMlMin,
    double? waterMlMax,
    double? fruitMin,
    double? fruitMax,
    double? vegMin,
    double? vegMax,
  }) => DayTypeTargetRow(
    dayType: dayType ?? this.dayType,
    kcalMin: kcalMin ?? this.kcalMin,
    kcalMax: kcalMax ?? this.kcalMax,
    carbsMin: carbsMin ?? this.carbsMin,
    carbsMax: carbsMax ?? this.carbsMax,
    fiberMin: fiberMin ?? this.fiberMin,
    fiberMax: fiberMax ?? this.fiberMax,
    waterMlMin: waterMlMin ?? this.waterMlMin,
    waterMlMax: waterMlMax ?? this.waterMlMax,
    fruitMin: fruitMin ?? this.fruitMin,
    fruitMax: fruitMax ?? this.fruitMax,
    vegMin: vegMin ?? this.vegMin,
    vegMax: vegMax ?? this.vegMax,
  );
  DayTypeTargetRow copyWithCompanion(DayTypeTargetRowsCompanion data) {
    return DayTypeTargetRow(
      dayType: data.dayType.present ? data.dayType.value : this.dayType,
      kcalMin: data.kcalMin.present ? data.kcalMin.value : this.kcalMin,
      kcalMax: data.kcalMax.present ? data.kcalMax.value : this.kcalMax,
      carbsMin: data.carbsMin.present ? data.carbsMin.value : this.carbsMin,
      carbsMax: data.carbsMax.present ? data.carbsMax.value : this.carbsMax,
      fiberMin: data.fiberMin.present ? data.fiberMin.value : this.fiberMin,
      fiberMax: data.fiberMax.present ? data.fiberMax.value : this.fiberMax,
      waterMlMin: data.waterMlMin.present
          ? data.waterMlMin.value
          : this.waterMlMin,
      waterMlMax: data.waterMlMax.present
          ? data.waterMlMax.value
          : this.waterMlMax,
      fruitMin: data.fruitMin.present ? data.fruitMin.value : this.fruitMin,
      fruitMax: data.fruitMax.present ? data.fruitMax.value : this.fruitMax,
      vegMin: data.vegMin.present ? data.vegMin.value : this.vegMin,
      vegMax: data.vegMax.present ? data.vegMax.value : this.vegMax,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayTypeTargetRow(')
          ..write('dayType: $dayType, ')
          ..write('kcalMin: $kcalMin, ')
          ..write('kcalMax: $kcalMax, ')
          ..write('carbsMin: $carbsMin, ')
          ..write('carbsMax: $carbsMax, ')
          ..write('fiberMin: $fiberMin, ')
          ..write('fiberMax: $fiberMax, ')
          ..write('waterMlMin: $waterMlMin, ')
          ..write('waterMlMax: $waterMlMax, ')
          ..write('fruitMin: $fruitMin, ')
          ..write('fruitMax: $fruitMax, ')
          ..write('vegMin: $vegMin, ')
          ..write('vegMax: $vegMax')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    dayType,
    kcalMin,
    kcalMax,
    carbsMin,
    carbsMax,
    fiberMin,
    fiberMax,
    waterMlMin,
    waterMlMax,
    fruitMin,
    fruitMax,
    vegMin,
    vegMax,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayTypeTargetRow &&
          other.dayType == this.dayType &&
          other.kcalMin == this.kcalMin &&
          other.kcalMax == this.kcalMax &&
          other.carbsMin == this.carbsMin &&
          other.carbsMax == this.carbsMax &&
          other.fiberMin == this.fiberMin &&
          other.fiberMax == this.fiberMax &&
          other.waterMlMin == this.waterMlMin &&
          other.waterMlMax == this.waterMlMax &&
          other.fruitMin == this.fruitMin &&
          other.fruitMax == this.fruitMax &&
          other.vegMin == this.vegMin &&
          other.vegMax == this.vegMax);
}

class DayTypeTargetRowsCompanion extends UpdateCompanion<DayTypeTargetRow> {
  final Value<DayType> dayType;
  final Value<double> kcalMin;
  final Value<double> kcalMax;
  final Value<double> carbsMin;
  final Value<double> carbsMax;
  final Value<double> fiberMin;
  final Value<double> fiberMax;
  final Value<double> waterMlMin;
  final Value<double> waterMlMax;
  final Value<double> fruitMin;
  final Value<double> fruitMax;
  final Value<double> vegMin;
  final Value<double> vegMax;
  final Value<int> rowid;
  const DayTypeTargetRowsCompanion({
    this.dayType = const Value.absent(),
    this.kcalMin = const Value.absent(),
    this.kcalMax = const Value.absent(),
    this.carbsMin = const Value.absent(),
    this.carbsMax = const Value.absent(),
    this.fiberMin = const Value.absent(),
    this.fiberMax = const Value.absent(),
    this.waterMlMin = const Value.absent(),
    this.waterMlMax = const Value.absent(),
    this.fruitMin = const Value.absent(),
    this.fruitMax = const Value.absent(),
    this.vegMin = const Value.absent(),
    this.vegMax = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DayTypeTargetRowsCompanion.insert({
    required DayType dayType,
    required double kcalMin,
    required double kcalMax,
    required double carbsMin,
    required double carbsMax,
    required double fiberMin,
    required double fiberMax,
    required double waterMlMin,
    required double waterMlMax,
    required double fruitMin,
    required double fruitMax,
    required double vegMin,
    required double vegMax,
    this.rowid = const Value.absent(),
  }) : dayType = Value(dayType),
       kcalMin = Value(kcalMin),
       kcalMax = Value(kcalMax),
       carbsMin = Value(carbsMin),
       carbsMax = Value(carbsMax),
       fiberMin = Value(fiberMin),
       fiberMax = Value(fiberMax),
       waterMlMin = Value(waterMlMin),
       waterMlMax = Value(waterMlMax),
       fruitMin = Value(fruitMin),
       fruitMax = Value(fruitMax),
       vegMin = Value(vegMin),
       vegMax = Value(vegMax);
  static Insertable<DayTypeTargetRow> custom({
    Expression<String>? dayType,
    Expression<double>? kcalMin,
    Expression<double>? kcalMax,
    Expression<double>? carbsMin,
    Expression<double>? carbsMax,
    Expression<double>? fiberMin,
    Expression<double>? fiberMax,
    Expression<double>? waterMlMin,
    Expression<double>? waterMlMax,
    Expression<double>? fruitMin,
    Expression<double>? fruitMax,
    Expression<double>? vegMin,
    Expression<double>? vegMax,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dayType != null) 'day_type': dayType,
      if (kcalMin != null) 'kcal_min': kcalMin,
      if (kcalMax != null) 'kcal_max': kcalMax,
      if (carbsMin != null) 'carbs_min': carbsMin,
      if (carbsMax != null) 'carbs_max': carbsMax,
      if (fiberMin != null) 'fiber_min': fiberMin,
      if (fiberMax != null) 'fiber_max': fiberMax,
      if (waterMlMin != null) 'water_ml_min': waterMlMin,
      if (waterMlMax != null) 'water_ml_max': waterMlMax,
      if (fruitMin != null) 'fruit_min': fruitMin,
      if (fruitMax != null) 'fruit_max': fruitMax,
      if (vegMin != null) 'veg_min': vegMin,
      if (vegMax != null) 'veg_max': vegMax,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DayTypeTargetRowsCompanion copyWith({
    Value<DayType>? dayType,
    Value<double>? kcalMin,
    Value<double>? kcalMax,
    Value<double>? carbsMin,
    Value<double>? carbsMax,
    Value<double>? fiberMin,
    Value<double>? fiberMax,
    Value<double>? waterMlMin,
    Value<double>? waterMlMax,
    Value<double>? fruitMin,
    Value<double>? fruitMax,
    Value<double>? vegMin,
    Value<double>? vegMax,
    Value<int>? rowid,
  }) {
    return DayTypeTargetRowsCompanion(
      dayType: dayType ?? this.dayType,
      kcalMin: kcalMin ?? this.kcalMin,
      kcalMax: kcalMax ?? this.kcalMax,
      carbsMin: carbsMin ?? this.carbsMin,
      carbsMax: carbsMax ?? this.carbsMax,
      fiberMin: fiberMin ?? this.fiberMin,
      fiberMax: fiberMax ?? this.fiberMax,
      waterMlMin: waterMlMin ?? this.waterMlMin,
      waterMlMax: waterMlMax ?? this.waterMlMax,
      fruitMin: fruitMin ?? this.fruitMin,
      fruitMax: fruitMax ?? this.fruitMax,
      vegMin: vegMin ?? this.vegMin,
      vegMax: vegMax ?? this.vegMax,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dayType.present) {
      map['day_type'] = Variable<String>(
        $DayTypeTargetRowsTable.$converterdayType.toSql(dayType.value),
      );
    }
    if (kcalMin.present) {
      map['kcal_min'] = Variable<double>(kcalMin.value);
    }
    if (kcalMax.present) {
      map['kcal_max'] = Variable<double>(kcalMax.value);
    }
    if (carbsMin.present) {
      map['carbs_min'] = Variable<double>(carbsMin.value);
    }
    if (carbsMax.present) {
      map['carbs_max'] = Variable<double>(carbsMax.value);
    }
    if (fiberMin.present) {
      map['fiber_min'] = Variable<double>(fiberMin.value);
    }
    if (fiberMax.present) {
      map['fiber_max'] = Variable<double>(fiberMax.value);
    }
    if (waterMlMin.present) {
      map['water_ml_min'] = Variable<double>(waterMlMin.value);
    }
    if (waterMlMax.present) {
      map['water_ml_max'] = Variable<double>(waterMlMax.value);
    }
    if (fruitMin.present) {
      map['fruit_min'] = Variable<double>(fruitMin.value);
    }
    if (fruitMax.present) {
      map['fruit_max'] = Variable<double>(fruitMax.value);
    }
    if (vegMin.present) {
      map['veg_min'] = Variable<double>(vegMin.value);
    }
    if (vegMax.present) {
      map['veg_max'] = Variable<double>(vegMax.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayTypeTargetRowsCompanion(')
          ..write('dayType: $dayType, ')
          ..write('kcalMin: $kcalMin, ')
          ..write('kcalMax: $kcalMax, ')
          ..write('carbsMin: $carbsMin, ')
          ..write('carbsMax: $carbsMax, ')
          ..write('fiberMin: $fiberMin, ')
          ..write('fiberMax: $fiberMax, ')
          ..write('waterMlMin: $waterMlMin, ')
          ..write('waterMlMax: $waterMlMax, ')
          ..write('fruitMin: $fruitMin, ')
          ..write('fruitMax: $fruitMax, ')
          ..write('vegMin: $vegMin, ')
          ..write('vegMax: $vegMax, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeekScheduleEntriesTable extends WeekScheduleEntries
    with TableInfo<$WeekScheduleEntriesTable, WeekScheduleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeekScheduleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    false,
    check: () => ComparableExpr(weekday).isBetweenValues(1, 7),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DayType, String> dayType =
      GeneratedColumn<String>(
        'day_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DayType>($WeekScheduleEntriesTable.$converterdayType);
  @override
  List<GeneratedColumn> get $columns => [weekday, dayType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'week_schedule_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeekScheduleEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {weekday};
  @override
  WeekScheduleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeekScheduleEntry(
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      )!,
      dayType: $WeekScheduleEntriesTable.$converterdayType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}day_type'],
        )!,
      ),
    );
  }

  @override
  $WeekScheduleEntriesTable createAlias(String alias) {
    return $WeekScheduleEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DayType, String, String> $converterdayType =
      const EnumNameConverter<DayType>(DayType.values);
}

class WeekScheduleEntry extends DataClass
    implements Insertable<WeekScheduleEntry> {
  /// 1 = Monday .. 7 = Sunday.
  final int weekday;
  final DayType dayType;
  const WeekScheduleEntry({required this.weekday, required this.dayType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['weekday'] = Variable<int>(weekday);
    {
      map['day_type'] = Variable<String>(
        $WeekScheduleEntriesTable.$converterdayType.toSql(dayType),
      );
    }
    return map;
  }

  WeekScheduleEntriesCompanion toCompanion(bool nullToAbsent) {
    return WeekScheduleEntriesCompanion(
      weekday: Value(weekday),
      dayType: Value(dayType),
    );
  }

  factory WeekScheduleEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeekScheduleEntry(
      weekday: serializer.fromJson<int>(json['weekday']),
      dayType: $WeekScheduleEntriesTable.$converterdayType.fromJson(
        serializer.fromJson<String>(json['dayType']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'weekday': serializer.toJson<int>(weekday),
      'dayType': serializer.toJson<String>(
        $WeekScheduleEntriesTable.$converterdayType.toJson(dayType),
      ),
    };
  }

  WeekScheduleEntry copyWith({int? weekday, DayType? dayType}) =>
      WeekScheduleEntry(
        weekday: weekday ?? this.weekday,
        dayType: dayType ?? this.dayType,
      );
  WeekScheduleEntry copyWithCompanion(WeekScheduleEntriesCompanion data) {
    return WeekScheduleEntry(
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
      dayType: data.dayType.present ? data.dayType.value : this.dayType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeekScheduleEntry(')
          ..write('weekday: $weekday, ')
          ..write('dayType: $dayType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(weekday, dayType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeekScheduleEntry &&
          other.weekday == this.weekday &&
          other.dayType == this.dayType);
}

class WeekScheduleEntriesCompanion extends UpdateCompanion<WeekScheduleEntry> {
  final Value<int> weekday;
  final Value<DayType> dayType;
  const WeekScheduleEntriesCompanion({
    this.weekday = const Value.absent(),
    this.dayType = const Value.absent(),
  });
  WeekScheduleEntriesCompanion.insert({
    this.weekday = const Value.absent(),
    required DayType dayType,
  }) : dayType = Value(dayType);
  static Insertable<WeekScheduleEntry> custom({
    Expression<int>? weekday,
    Expression<String>? dayType,
  }) {
    return RawValuesInsertable({
      if (weekday != null) 'weekday': weekday,
      if (dayType != null) 'day_type': dayType,
    });
  }

  WeekScheduleEntriesCompanion copyWith({
    Value<int>? weekday,
    Value<DayType>? dayType,
  }) {
    return WeekScheduleEntriesCompanion(
      weekday: weekday ?? this.weekday,
      dayType: dayType ?? this.dayType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    if (dayType.present) {
      map['day_type'] = Variable<String>(
        $WeekScheduleEntriesTable.$converterdayType.toSql(dayType.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeekScheduleEntriesCompanion(')
          ..write('weekday: $weekday, ')
          ..write('dayType: $dayType')
          ..write(')'))
        .toString();
  }
}

class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, Ingredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFruitMeta = const VerificationMeta(
    'isFruit',
  );
  @override
  late final GeneratedColumn<bool> isFruit = GeneratedColumn<bool>(
    'is_fruit',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fruit" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isVegetableMeta = const VerificationMeta(
    'isVegetable',
  );
  @override
  late final GeneratedColumn<bool> isVegetable = GeneratedColumn<bool>(
    'is_vegetable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_vegetable" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _servingGMeta = const VerificationMeta(
    'servingG',
  );
  @override
  late final GeneratedColumn<double> servingG = GeneratedColumn<double>(
    'serving_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kcal100Meta = const VerificationMeta(
    'kcal100',
  );
  @override
  late final GeneratedColumn<double> kcal100 = GeneratedColumn<double>(
    'kcal100',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _protein100Meta = const VerificationMeta(
    'protein100',
  );
  @override
  late final GeneratedColumn<double> protein100 = GeneratedColumn<double>(
    'protein100',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fat100Meta = const VerificationMeta('fat100');
  @override
  late final GeneratedColumn<double> fat100 = GeneratedColumn<double>(
    'fat100',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbs100Meta = const VerificationMeta(
    'carbs100',
  );
  @override
  late final GeneratedColumn<double> carbs100 = GeneratedColumn<double>(
    'carbs100',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fiber100Meta = const VerificationMeta(
    'fiber100',
  );
  @override
  late final GeneratedColumn<double> fiber100 = GeneratedColumn<double>(
    'fiber100',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    isFruit,
    isVegetable,
    servingG,
    kcal100,
    protein100,
    fat100,
    carbs100,
    fiber100,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ingredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_fruit')) {
      context.handle(
        _isFruitMeta,
        isFruit.isAcceptableOrUnknown(data['is_fruit']!, _isFruitMeta),
      );
    }
    if (data.containsKey('is_vegetable')) {
      context.handle(
        _isVegetableMeta,
        isVegetable.isAcceptableOrUnknown(
          data['is_vegetable']!,
          _isVegetableMeta,
        ),
      );
    }
    if (data.containsKey('serving_g')) {
      context.handle(
        _servingGMeta,
        servingG.isAcceptableOrUnknown(data['serving_g']!, _servingGMeta),
      );
    }
    if (data.containsKey('kcal100')) {
      context.handle(
        _kcal100Meta,
        kcal100.isAcceptableOrUnknown(data['kcal100']!, _kcal100Meta),
      );
    } else if (isInserting) {
      context.missing(_kcal100Meta);
    }
    if (data.containsKey('protein100')) {
      context.handle(
        _protein100Meta,
        protein100.isAcceptableOrUnknown(data['protein100']!, _protein100Meta),
      );
    } else if (isInserting) {
      context.missing(_protein100Meta);
    }
    if (data.containsKey('fat100')) {
      context.handle(
        _fat100Meta,
        fat100.isAcceptableOrUnknown(data['fat100']!, _fat100Meta),
      );
    } else if (isInserting) {
      context.missing(_fat100Meta);
    }
    if (data.containsKey('carbs100')) {
      context.handle(
        _carbs100Meta,
        carbs100.isAcceptableOrUnknown(data['carbs100']!, _carbs100Meta),
      );
    } else if (isInserting) {
      context.missing(_carbs100Meta);
    }
    if (data.containsKey('fiber100')) {
      context.handle(
        _fiber100Meta,
        fiber100.isAcceptableOrUnknown(data['fiber100']!, _fiber100Meta),
      );
    } else if (isInserting) {
      context.missing(_fiber100Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isFruit: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fruit'],
      )!,
      isVegetable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_vegetable'],
      )!,
      servingG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}serving_g'],
      ),
      kcal100: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kcal100'],
      )!,
      protein100: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein100'],
      )!,
      fat100: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat100'],
      )!,
      carbs100: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs100'],
      )!,
      fiber100: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber100'],
      )!,
    );
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(attachedDatabase, alias);
  }
}

class Ingredient extends DataClass implements Insertable<Ingredient> {
  final int id;
  final String name;
  final String category;
  final bool isFruit;
  final bool isVegetable;
  final double? servingG;
  final double kcal100;
  final double protein100;
  final double fat100;
  final double carbs100;
  final double fiber100;
  const Ingredient({
    required this.id,
    required this.name,
    required this.category,
    required this.isFruit,
    required this.isVegetable,
    this.servingG,
    required this.kcal100,
    required this.protein100,
    required this.fat100,
    required this.carbs100,
    required this.fiber100,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['is_fruit'] = Variable<bool>(isFruit);
    map['is_vegetable'] = Variable<bool>(isVegetable);
    if (!nullToAbsent || servingG != null) {
      map['serving_g'] = Variable<double>(servingG);
    }
    map['kcal100'] = Variable<double>(kcal100);
    map['protein100'] = Variable<double>(protein100);
    map['fat100'] = Variable<double>(fat100);
    map['carbs100'] = Variable<double>(carbs100);
    map['fiber100'] = Variable<double>(fiber100);
    return map;
  }

  IngredientsCompanion toCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      isFruit: Value(isFruit),
      isVegetable: Value(isVegetable),
      servingG: servingG == null && nullToAbsent
          ? const Value.absent()
          : Value(servingG),
      kcal100: Value(kcal100),
      protein100: Value(protein100),
      fat100: Value(fat100),
      carbs100: Value(carbs100),
      fiber100: Value(fiber100),
    );
  }

  factory Ingredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingredient(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      isFruit: serializer.fromJson<bool>(json['isFruit']),
      isVegetable: serializer.fromJson<bool>(json['isVegetable']),
      servingG: serializer.fromJson<double?>(json['servingG']),
      kcal100: serializer.fromJson<double>(json['kcal100']),
      protein100: serializer.fromJson<double>(json['protein100']),
      fat100: serializer.fromJson<double>(json['fat100']),
      carbs100: serializer.fromJson<double>(json['carbs100']),
      fiber100: serializer.fromJson<double>(json['fiber100']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'isFruit': serializer.toJson<bool>(isFruit),
      'isVegetable': serializer.toJson<bool>(isVegetable),
      'servingG': serializer.toJson<double?>(servingG),
      'kcal100': serializer.toJson<double>(kcal100),
      'protein100': serializer.toJson<double>(protein100),
      'fat100': serializer.toJson<double>(fat100),
      'carbs100': serializer.toJson<double>(carbs100),
      'fiber100': serializer.toJson<double>(fiber100),
    };
  }

  Ingredient copyWith({
    int? id,
    String? name,
    String? category,
    bool? isFruit,
    bool? isVegetable,
    Value<double?> servingG = const Value.absent(),
    double? kcal100,
    double? protein100,
    double? fat100,
    double? carbs100,
    double? fiber100,
  }) => Ingredient(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    isFruit: isFruit ?? this.isFruit,
    isVegetable: isVegetable ?? this.isVegetable,
    servingG: servingG.present ? servingG.value : this.servingG,
    kcal100: kcal100 ?? this.kcal100,
    protein100: protein100 ?? this.protein100,
    fat100: fat100 ?? this.fat100,
    carbs100: carbs100 ?? this.carbs100,
    fiber100: fiber100 ?? this.fiber100,
  );
  Ingredient copyWithCompanion(IngredientsCompanion data) {
    return Ingredient(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      isFruit: data.isFruit.present ? data.isFruit.value : this.isFruit,
      isVegetable: data.isVegetable.present
          ? data.isVegetable.value
          : this.isVegetable,
      servingG: data.servingG.present ? data.servingG.value : this.servingG,
      kcal100: data.kcal100.present ? data.kcal100.value : this.kcal100,
      protein100: data.protein100.present
          ? data.protein100.value
          : this.protein100,
      fat100: data.fat100.present ? data.fat100.value : this.fat100,
      carbs100: data.carbs100.present ? data.carbs100.value : this.carbs100,
      fiber100: data.fiber100.present ? data.fiber100.value : this.fiber100,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingredient(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isFruit: $isFruit, ')
          ..write('isVegetable: $isVegetable, ')
          ..write('servingG: $servingG, ')
          ..write('kcal100: $kcal100, ')
          ..write('protein100: $protein100, ')
          ..write('fat100: $fat100, ')
          ..write('carbs100: $carbs100, ')
          ..write('fiber100: $fiber100')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    isFruit,
    isVegetable,
    servingG,
    kcal100,
    protein100,
    fat100,
    carbs100,
    fiber100,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingredient &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.isFruit == this.isFruit &&
          other.isVegetable == this.isVegetable &&
          other.servingG == this.servingG &&
          other.kcal100 == this.kcal100 &&
          other.protein100 == this.protein100 &&
          other.fat100 == this.fat100 &&
          other.carbs100 == this.carbs100 &&
          other.fiber100 == this.fiber100);
}

class IngredientsCompanion extends UpdateCompanion<Ingredient> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<bool> isFruit;
  final Value<bool> isVegetable;
  final Value<double?> servingG;
  final Value<double> kcal100;
  final Value<double> protein100;
  final Value<double> fat100;
  final Value<double> carbs100;
  final Value<double> fiber100;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.isFruit = const Value.absent(),
    this.isVegetable = const Value.absent(),
    this.servingG = const Value.absent(),
    this.kcal100 = const Value.absent(),
    this.protein100 = const Value.absent(),
    this.fat100 = const Value.absent(),
    this.carbs100 = const Value.absent(),
    this.fiber100 = const Value.absent(),
  });
  IngredientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    this.isFruit = const Value.absent(),
    this.isVegetable = const Value.absent(),
    this.servingG = const Value.absent(),
    required double kcal100,
    required double protein100,
    required double fat100,
    required double carbs100,
    required double fiber100,
  }) : name = Value(name),
       category = Value(category),
       kcal100 = Value(kcal100),
       protein100 = Value(protein100),
       fat100 = Value(fat100),
       carbs100 = Value(carbs100),
       fiber100 = Value(fiber100);
  static Insertable<Ingredient> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<bool>? isFruit,
    Expression<bool>? isVegetable,
    Expression<double>? servingG,
    Expression<double>? kcal100,
    Expression<double>? protein100,
    Expression<double>? fat100,
    Expression<double>? carbs100,
    Expression<double>? fiber100,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (isFruit != null) 'is_fruit': isFruit,
      if (isVegetable != null) 'is_vegetable': isVegetable,
      if (servingG != null) 'serving_g': servingG,
      if (kcal100 != null) 'kcal100': kcal100,
      if (protein100 != null) 'protein100': protein100,
      if (fat100 != null) 'fat100': fat100,
      if (carbs100 != null) 'carbs100': carbs100,
      if (fiber100 != null) 'fiber100': fiber100,
    });
  }

  IngredientsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<bool>? isFruit,
    Value<bool>? isVegetable,
    Value<double?>? servingG,
    Value<double>? kcal100,
    Value<double>? protein100,
    Value<double>? fat100,
    Value<double>? carbs100,
    Value<double>? fiber100,
  }) {
    return IngredientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isFruit: isFruit ?? this.isFruit,
      isVegetable: isVegetable ?? this.isVegetable,
      servingG: servingG ?? this.servingG,
      kcal100: kcal100 ?? this.kcal100,
      protein100: protein100 ?? this.protein100,
      fat100: fat100 ?? this.fat100,
      carbs100: carbs100 ?? this.carbs100,
      fiber100: fiber100 ?? this.fiber100,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isFruit.present) {
      map['is_fruit'] = Variable<bool>(isFruit.value);
    }
    if (isVegetable.present) {
      map['is_vegetable'] = Variable<bool>(isVegetable.value);
    }
    if (servingG.present) {
      map['serving_g'] = Variable<double>(servingG.value);
    }
    if (kcal100.present) {
      map['kcal100'] = Variable<double>(kcal100.value);
    }
    if (protein100.present) {
      map['protein100'] = Variable<double>(protein100.value);
    }
    if (fat100.present) {
      map['fat100'] = Variable<double>(fat100.value);
    }
    if (carbs100.present) {
      map['carbs100'] = Variable<double>(carbs100.value);
    }
    if (fiber100.present) {
      map['fiber100'] = Variable<double>(fiber100.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isFruit: $isFruit, ')
          ..write('isVegetable: $isVegetable, ')
          ..write('servingG: $servingG, ')
          ..write('kcal100: $kcal100, ')
          ..write('protein100: $protein100, ')
          ..write('fat100: $fat100, ')
          ..write('carbs100: $carbs100, ')
          ..write('fiber100: $fiber100')
          ..write(')'))
        .toString();
  }
}

class $ToolsTable extends Tools with TableInfo<$ToolsTable, Tool> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ToolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tools';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tool> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tool map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tool(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ToolsTable createAlias(String alias) {
    return $ToolsTable(attachedDatabase, alias);
  }
}

class Tool extends DataClass implements Insertable<Tool> {
  final int id;
  final String name;
  const Tool({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ToolsCompanion toCompanion(bool nullToAbsent) {
    return ToolsCompanion(id: Value(id), name: Value(name));
  }

  factory Tool.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tool(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Tool copyWith({int? id, String? name}) =>
      Tool(id: id ?? this.id, name: name ?? this.name);
  Tool copyWithCompanion(ToolsCompanion data) {
    return Tool(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tool(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tool && other.id == this.id && other.name == this.name);
}

class ToolsCompanion extends UpdateCompanion<Tool> {
  final Value<int> id;
  final Value<String> name;
  const ToolsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ToolsCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<Tool> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ToolsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ToolsCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ToolsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RecipeKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RecipeKind>($RecipesTable.$converterkind);
  static const VerificationMeta _expectedYieldFactorMeta =
      const VerificationMeta('expectedYieldFactor');
  @override
  late final GeneratedColumn<double> expectedYieldFactor =
      GeneratedColumn<double>(
        'expected_yield_factor',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(1.0),
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    kind,
    expectedYieldFactor,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('expected_yield_factor')) {
      context.handle(
        _expectedYieldFactorMeta,
        expectedYieldFactor.isAcceptableOrUnknown(
          data['expected_yield_factor']!,
          _expectedYieldFactorMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: $RecipesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      expectedYieldFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_yield_factor'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RecipeKind, String, String> $converterkind =
      const EnumNameConverter<RecipeKind>(RecipeKind.values);
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String name;
  final RecipeKind kind;
  final double expectedYieldFactor;
  final String? notes;
  final DateTime createdAt;
  const Recipe({
    required this.id,
    required this.name,
    required this.kind,
    required this.expectedYieldFactor,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['kind'] = Variable<String>($RecipesTable.$converterkind.toSql(kind));
    }
    map['expected_yield_factor'] = Variable<double>(expectedYieldFactor);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      name: Value(name),
      kind: Value(kind),
      expectedYieldFactor: Value(expectedYieldFactor),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      kind: $RecipesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      expectedYieldFactor: serializer.fromJson<double>(
        json['expectedYieldFactor'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(
        $RecipesTable.$converterkind.toJson(kind),
      ),
      'expectedYieldFactor': serializer.toJson<double>(expectedYieldFactor),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Recipe copyWith({
    int? id,
    String? name,
    RecipeKind? kind,
    double? expectedYieldFactor,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Recipe(
    id: id ?? this.id,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    expectedYieldFactor: expectedYieldFactor ?? this.expectedYieldFactor,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      expectedYieldFactor: data.expectedYieldFactor.present
          ? data.expectedYieldFactor.value
          : this.expectedYieldFactor,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('expectedYieldFactor: $expectedYieldFactor, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, kind, expectedYieldFactor, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.expectedYieldFactor == this.expectedYieldFactor &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> name;
  final Value<RecipeKind> kind;
  final Value<double> expectedYieldFactor;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.expectedYieldFactor = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required RecipeKind kind,
    this.expectedYieldFactor = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       kind = Value(kind);
  static Insertable<Recipe> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<double>? expectedYieldFactor,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (expectedYieldFactor != null)
        'expected_yield_factor': expectedYieldFactor,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<RecipeKind>? kind,
    Value<double>? expectedYieldFactor,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      expectedYieldFactor: expectedYieldFactor ?? this.expectedYieldFactor,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $RecipesTable.$converterkind.toSql(kind.value),
      );
    }
    if (expectedYieldFactor.present) {
      map['expected_yield_factor'] = Variable<double>(
        expectedYieldFactor.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('expectedYieldFactor: $expectedYieldFactor, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RecipeIngredientsTable extends RecipeIngredients
    with TableInfo<$RecipeIngredientsTable, RecipeIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _rawGMeta = const VerificationMeta('rawG');
  @override
  late final GeneratedColumn<double> rawG = GeneratedColumn<double>(
    'raw_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [recipeId, ingredientId, rawG];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('raw_g')) {
      context.handle(
        _rawGMeta,
        rawG.isAcceptableOrUnknown(data['raw_g']!, _rawGMeta),
      );
    } else if (isInserting) {
      context.missing(_rawGMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeId, ingredientId};
  @override
  RecipeIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeIngredient(
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      rawG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}raw_g'],
      )!,
    );
  }

  @override
  $RecipeIngredientsTable createAlias(String alias) {
    return $RecipeIngredientsTable(attachedDatabase, alias);
  }
}

class RecipeIngredient extends DataClass
    implements Insertable<RecipeIngredient> {
  final int recipeId;
  final int ingredientId;
  final double rawG;
  const RecipeIngredient({
    required this.recipeId,
    required this.ingredientId,
    required this.rawG,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_id'] = Variable<int>(recipeId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['raw_g'] = Variable<double>(rawG);
    return map;
  }

  RecipeIngredientsCompanion toCompanion(bool nullToAbsent) {
    return RecipeIngredientsCompanion(
      recipeId: Value(recipeId),
      ingredientId: Value(ingredientId),
      rawG: Value(rawG),
    );
  }

  factory RecipeIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeIngredient(
      recipeId: serializer.fromJson<int>(json['recipeId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      rawG: serializer.fromJson<double>(json['rawG']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeId': serializer.toJson<int>(recipeId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'rawG': serializer.toJson<double>(rawG),
    };
  }

  RecipeIngredient copyWith({int? recipeId, int? ingredientId, double? rawG}) =>
      RecipeIngredient(
        recipeId: recipeId ?? this.recipeId,
        ingredientId: ingredientId ?? this.ingredientId,
        rawG: rawG ?? this.rawG,
      );
  RecipeIngredient copyWithCompanion(RecipeIngredientsCompanion data) {
    return RecipeIngredient(
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      rawG: data.rawG.present ? data.rawG.value : this.rawG,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredient(')
          ..write('recipeId: $recipeId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('rawG: $rawG')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recipeId, ingredientId, rawG);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeIngredient &&
          other.recipeId == this.recipeId &&
          other.ingredientId == this.ingredientId &&
          other.rawG == this.rawG);
}

class RecipeIngredientsCompanion extends UpdateCompanion<RecipeIngredient> {
  final Value<int> recipeId;
  final Value<int> ingredientId;
  final Value<double> rawG;
  final Value<int> rowid;
  const RecipeIngredientsCompanion({
    this.recipeId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.rawG = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipeIngredientsCompanion.insert({
    required int recipeId,
    required int ingredientId,
    required double rawG,
    this.rowid = const Value.absent(),
  }) : recipeId = Value(recipeId),
       ingredientId = Value(ingredientId),
       rawG = Value(rawG);
  static Insertable<RecipeIngredient> custom({
    Expression<int>? recipeId,
    Expression<int>? ingredientId,
    Expression<double>? rawG,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recipeId != null) 'recipe_id': recipeId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (rawG != null) 'raw_g': rawG,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipeIngredientsCompanion copyWith({
    Value<int>? recipeId,
    Value<int>? ingredientId,
    Value<double>? rawG,
    Value<int>? rowid,
  }) {
    return RecipeIngredientsCompanion(
      recipeId: recipeId ?? this.recipeId,
      ingredientId: ingredientId ?? this.ingredientId,
      rawG: rawG ?? this.rawG,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (rawG.present) {
      map['raw_g'] = Variable<double>(rawG.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientsCompanion(')
          ..write('recipeId: $recipeId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('rawG: $rawG, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipeStepsTable extends RecipeSteps
    with TableInfo<$RecipeStepsTable, RecipeStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _techniqueMeta = const VerificationMeta(
    'technique',
  );
  @override
  late final GeneratedColumn<String> technique = GeneratedColumn<String>(
    'technique',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<int> tempC = GeneratedColumn<int>(
    'temp_c',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minutesMeta = const VerificationMeta(
    'minutes',
  );
  @override
  late final GeneratedColumn<int> minutes = GeneratedColumn<int>(
    'minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<int> toolId = GeneratedColumn<int>(
    'tool_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tools (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    position,
    technique,
    tempC,
    minutes,
    toolId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('technique')) {
      context.handle(
        _techniqueMeta,
        technique.isAcceptableOrUnknown(data['technique']!, _techniqueMeta),
      );
    } else if (isInserting) {
      context.missing(_techniqueMeta);
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    }
    if (data.containsKey('minutes')) {
      context.handle(
        _minutesMeta,
        minutes.isAcceptableOrUnknown(data['minutes']!, _minutesMeta),
      );
    }
    if (data.containsKey('tool_id')) {
      context.handle(
        _toolIdMeta,
        toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      technique: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technique'],
      )!,
      tempC: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}temp_c'],
      ),
      minutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes'],
      ),
      toolId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tool_id'],
      ),
    );
  }

  @override
  $RecipeStepsTable createAlias(String alias) {
    return $RecipeStepsTable(attachedDatabase, alias);
  }
}

class RecipeStep extends DataClass implements Insertable<RecipeStep> {
  final int id;
  final int recipeId;
  final int position;
  final String technique;
  final int? tempC;
  final int? minutes;
  final int? toolId;
  const RecipeStep({
    required this.id,
    required this.recipeId,
    required this.position,
    required this.technique,
    this.tempC,
    this.minutes,
    this.toolId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['position'] = Variable<int>(position);
    map['technique'] = Variable<String>(technique);
    if (!nullToAbsent || tempC != null) {
      map['temp_c'] = Variable<int>(tempC);
    }
    if (!nullToAbsent || minutes != null) {
      map['minutes'] = Variable<int>(minutes);
    }
    if (!nullToAbsent || toolId != null) {
      map['tool_id'] = Variable<int>(toolId);
    }
    return map;
  }

  RecipeStepsCompanion toCompanion(bool nullToAbsent) {
    return RecipeStepsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      position: Value(position),
      technique: Value(technique),
      tempC: tempC == null && nullToAbsent
          ? const Value.absent()
          : Value(tempC),
      minutes: minutes == null && nullToAbsent
          ? const Value.absent()
          : Value(minutes),
      toolId: toolId == null && nullToAbsent
          ? const Value.absent()
          : Value(toolId),
    );
  }

  factory RecipeStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeStep(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      position: serializer.fromJson<int>(json['position']),
      technique: serializer.fromJson<String>(json['technique']),
      tempC: serializer.fromJson<int?>(json['tempC']),
      minutes: serializer.fromJson<int?>(json['minutes']),
      toolId: serializer.fromJson<int?>(json['toolId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'position': serializer.toJson<int>(position),
      'technique': serializer.toJson<String>(technique),
      'tempC': serializer.toJson<int?>(tempC),
      'minutes': serializer.toJson<int?>(minutes),
      'toolId': serializer.toJson<int?>(toolId),
    };
  }

  RecipeStep copyWith({
    int? id,
    int? recipeId,
    int? position,
    String? technique,
    Value<int?> tempC = const Value.absent(),
    Value<int?> minutes = const Value.absent(),
    Value<int?> toolId = const Value.absent(),
  }) => RecipeStep(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    position: position ?? this.position,
    technique: technique ?? this.technique,
    tempC: tempC.present ? tempC.value : this.tempC,
    minutes: minutes.present ? minutes.value : this.minutes,
    toolId: toolId.present ? toolId.value : this.toolId,
  );
  RecipeStep copyWithCompanion(RecipeStepsCompanion data) {
    return RecipeStep(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      position: data.position.present ? data.position.value : this.position,
      technique: data.technique.present ? data.technique.value : this.technique,
      tempC: data.tempC.present ? data.tempC.value : this.tempC,
      minutes: data.minutes.present ? data.minutes.value : this.minutes,
      toolId: data.toolId.present ? data.toolId.value : this.toolId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeStep(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('position: $position, ')
          ..write('technique: $technique, ')
          ..write('tempC: $tempC, ')
          ..write('minutes: $minutes, ')
          ..write('toolId: $toolId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, recipeId, position, technique, tempC, minutes, toolId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeStep &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.position == this.position &&
          other.technique == this.technique &&
          other.tempC == this.tempC &&
          other.minutes == this.minutes &&
          other.toolId == this.toolId);
}

class RecipeStepsCompanion extends UpdateCompanion<RecipeStep> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<int> position;
  final Value<String> technique;
  final Value<int?> tempC;
  final Value<int?> minutes;
  final Value<int?> toolId;
  const RecipeStepsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.position = const Value.absent(),
    this.technique = const Value.absent(),
    this.tempC = const Value.absent(),
    this.minutes = const Value.absent(),
    this.toolId = const Value.absent(),
  });
  RecipeStepsCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required int position,
    required String technique,
    this.tempC = const Value.absent(),
    this.minutes = const Value.absent(),
    this.toolId = const Value.absent(),
  }) : recipeId = Value(recipeId),
       position = Value(position),
       technique = Value(technique);
  static Insertable<RecipeStep> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<int>? position,
    Expression<String>? technique,
    Expression<int>? tempC,
    Expression<int>? minutes,
    Expression<int>? toolId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (position != null) 'position': position,
      if (technique != null) 'technique': technique,
      if (tempC != null) 'temp_c': tempC,
      if (minutes != null) 'minutes': minutes,
      if (toolId != null) 'tool_id': toolId,
    });
  }

  RecipeStepsCompanion copyWith({
    Value<int>? id,
    Value<int>? recipeId,
    Value<int>? position,
    Value<String>? technique,
    Value<int?>? tempC,
    Value<int?>? minutes,
    Value<int?>? toolId,
  }) {
    return RecipeStepsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      position: position ?? this.position,
      technique: technique ?? this.technique,
      tempC: tempC ?? this.tempC,
      minutes: minutes ?? this.minutes,
      toolId: toolId ?? this.toolId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (technique.present) {
      map['technique'] = Variable<String>(technique.value);
    }
    if (tempC.present) {
      map['temp_c'] = Variable<int>(tempC.value);
    }
    if (minutes.present) {
      map['minutes'] = Variable<int>(minutes.value);
    }
    if (toolId.present) {
      map['tool_id'] = Variable<int>(toolId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeStepsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('position: $position, ')
          ..write('technique: $technique, ')
          ..write('tempC: $tempC, ')
          ..write('minutes: $minutes, ')
          ..write('toolId: $toolId')
          ..write(')'))
        .toString();
  }
}

class $RecipeToolsTable extends RecipeTools
    with TableInfo<$RecipeToolsTable, RecipeTool> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeToolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _toolIdMeta = const VerificationMeta('toolId');
  @override
  late final GeneratedColumn<int> toolId = GeneratedColumn<int>(
    'tool_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tools (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [recipeId, toolId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_tools';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeTool> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('tool_id')) {
      context.handle(
        _toolIdMeta,
        toolId.isAcceptableOrUnknown(data['tool_id']!, _toolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_toolIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeId, toolId};
  @override
  RecipeTool map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeTool(
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      toolId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tool_id'],
      )!,
    );
  }

  @override
  $RecipeToolsTable createAlias(String alias) {
    return $RecipeToolsTable(attachedDatabase, alias);
  }
}

class RecipeTool extends DataClass implements Insertable<RecipeTool> {
  final int recipeId;
  final int toolId;
  const RecipeTool({required this.recipeId, required this.toolId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_id'] = Variable<int>(recipeId);
    map['tool_id'] = Variable<int>(toolId);
    return map;
  }

  RecipeToolsCompanion toCompanion(bool nullToAbsent) {
    return RecipeToolsCompanion(
      recipeId: Value(recipeId),
      toolId: Value(toolId),
    );
  }

  factory RecipeTool.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeTool(
      recipeId: serializer.fromJson<int>(json['recipeId']),
      toolId: serializer.fromJson<int>(json['toolId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeId': serializer.toJson<int>(recipeId),
      'toolId': serializer.toJson<int>(toolId),
    };
  }

  RecipeTool copyWith({int? recipeId, int? toolId}) => RecipeTool(
    recipeId: recipeId ?? this.recipeId,
    toolId: toolId ?? this.toolId,
  );
  RecipeTool copyWithCompanion(RecipeToolsCompanion data) {
    return RecipeTool(
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      toolId: data.toolId.present ? data.toolId.value : this.toolId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeTool(')
          ..write('recipeId: $recipeId, ')
          ..write('toolId: $toolId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recipeId, toolId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeTool &&
          other.recipeId == this.recipeId &&
          other.toolId == this.toolId);
}

class RecipeToolsCompanion extends UpdateCompanion<RecipeTool> {
  final Value<int> recipeId;
  final Value<int> toolId;
  final Value<int> rowid;
  const RecipeToolsCompanion({
    this.recipeId = const Value.absent(),
    this.toolId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipeToolsCompanion.insert({
    required int recipeId,
    required int toolId,
    this.rowid = const Value.absent(),
  }) : recipeId = Value(recipeId),
       toolId = Value(toolId);
  static Insertable<RecipeTool> custom({
    Expression<int>? recipeId,
    Expression<int>? toolId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recipeId != null) 'recipe_id': recipeId,
      if (toolId != null) 'tool_id': toolId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipeToolsCompanion copyWith({
    Value<int>? recipeId,
    Value<int>? toolId,
    Value<int>? rowid,
  }) {
    return RecipeToolsCompanion(
      recipeId: recipeId ?? this.recipeId,
      toolId: toolId ?? this.toolId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (toolId.present) {
      map['tool_id'] = Variable<int>(toolId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeToolsCompanion(')
          ..write('recipeId: $recipeId, ')
          ..write('toolId: $toolId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BatchSessionsTable extends BatchSessions
    with TableInfo<$BatchSessionsTable, BatchSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _cookedOnMeta = const VerificationMeta(
    'cookedOn',
  );
  @override
  late final GeneratedColumn<DateTime> cookedOn = GeneratedColumn<DateTime>(
    'cooked_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coversFromMeta = const VerificationMeta(
    'coversFrom',
  );
  @override
  late final GeneratedColumn<DateTime> coversFrom = GeneratedColumn<DateTime>(
    'covers_from',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coversToMeta = const VerificationMeta(
    'coversTo',
  );
  @override
  late final GeneratedColumn<DateTime> coversTo = GeneratedColumn<DateTime>(
    'covers_to',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, cookedOn, coversFrom, coversTo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batch_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatchSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cooked_on')) {
      context.handle(
        _cookedOnMeta,
        cookedOn.isAcceptableOrUnknown(data['cooked_on']!, _cookedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_cookedOnMeta);
    }
    if (data.containsKey('covers_from')) {
      context.handle(
        _coversFromMeta,
        coversFrom.isAcceptableOrUnknown(data['covers_from']!, _coversFromMeta),
      );
    } else if (isInserting) {
      context.missing(_coversFromMeta);
    }
    if (data.containsKey('covers_to')) {
      context.handle(
        _coversToMeta,
        coversTo.isAcceptableOrUnknown(data['covers_to']!, _coversToMeta),
      );
    } else if (isInserting) {
      context.missing(_coversToMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BatchSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatchSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      cookedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cooked_on'],
      )!,
      coversFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}covers_from'],
      )!,
      coversTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}covers_to'],
      )!,
    );
  }

  @override
  $BatchSessionsTable createAlias(String alias) {
    return $BatchSessionsTable(attachedDatabase, alias);
  }
}

class BatchSession extends DataClass implements Insertable<BatchSession> {
  final int id;
  final DateTime cookedOn;
  final DateTime coversFrom;
  final DateTime coversTo;
  const BatchSession({
    required this.id,
    required this.cookedOn,
    required this.coversFrom,
    required this.coversTo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cooked_on'] = Variable<DateTime>(cookedOn);
    map['covers_from'] = Variable<DateTime>(coversFrom);
    map['covers_to'] = Variable<DateTime>(coversTo);
    return map;
  }

  BatchSessionsCompanion toCompanion(bool nullToAbsent) {
    return BatchSessionsCompanion(
      id: Value(id),
      cookedOn: Value(cookedOn),
      coversFrom: Value(coversFrom),
      coversTo: Value(coversTo),
    );
  }

  factory BatchSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatchSession(
      id: serializer.fromJson<int>(json['id']),
      cookedOn: serializer.fromJson<DateTime>(json['cookedOn']),
      coversFrom: serializer.fromJson<DateTime>(json['coversFrom']),
      coversTo: serializer.fromJson<DateTime>(json['coversTo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cookedOn': serializer.toJson<DateTime>(cookedOn),
      'coversFrom': serializer.toJson<DateTime>(coversFrom),
      'coversTo': serializer.toJson<DateTime>(coversTo),
    };
  }

  BatchSession copyWith({
    int? id,
    DateTime? cookedOn,
    DateTime? coversFrom,
    DateTime? coversTo,
  }) => BatchSession(
    id: id ?? this.id,
    cookedOn: cookedOn ?? this.cookedOn,
    coversFrom: coversFrom ?? this.coversFrom,
    coversTo: coversTo ?? this.coversTo,
  );
  BatchSession copyWithCompanion(BatchSessionsCompanion data) {
    return BatchSession(
      id: data.id.present ? data.id.value : this.id,
      cookedOn: data.cookedOn.present ? data.cookedOn.value : this.cookedOn,
      coversFrom: data.coversFrom.present
          ? data.coversFrom.value
          : this.coversFrom,
      coversTo: data.coversTo.present ? data.coversTo.value : this.coversTo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatchSession(')
          ..write('id: $id, ')
          ..write('cookedOn: $cookedOn, ')
          ..write('coversFrom: $coversFrom, ')
          ..write('coversTo: $coversTo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cookedOn, coversFrom, coversTo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatchSession &&
          other.id == this.id &&
          other.cookedOn == this.cookedOn &&
          other.coversFrom == this.coversFrom &&
          other.coversTo == this.coversTo);
}

class BatchSessionsCompanion extends UpdateCompanion<BatchSession> {
  final Value<int> id;
  final Value<DateTime> cookedOn;
  final Value<DateTime> coversFrom;
  final Value<DateTime> coversTo;
  const BatchSessionsCompanion({
    this.id = const Value.absent(),
    this.cookedOn = const Value.absent(),
    this.coversFrom = const Value.absent(),
    this.coversTo = const Value.absent(),
  });
  BatchSessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime cookedOn,
    required DateTime coversFrom,
    required DateTime coversTo,
  }) : cookedOn = Value(cookedOn),
       coversFrom = Value(coversFrom),
       coversTo = Value(coversTo);
  static Insertable<BatchSession> custom({
    Expression<int>? id,
    Expression<DateTime>? cookedOn,
    Expression<DateTime>? coversFrom,
    Expression<DateTime>? coversTo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cookedOn != null) 'cooked_on': cookedOn,
      if (coversFrom != null) 'covers_from': coversFrom,
      if (coversTo != null) 'covers_to': coversTo,
    });
  }

  BatchSessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? cookedOn,
    Value<DateTime>? coversFrom,
    Value<DateTime>? coversTo,
  }) {
    return BatchSessionsCompanion(
      id: id ?? this.id,
      cookedOn: cookedOn ?? this.cookedOn,
      coversFrom: coversFrom ?? this.coversFrom,
      coversTo: coversTo ?? this.coversTo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cookedOn.present) {
      map['cooked_on'] = Variable<DateTime>(cookedOn.value);
    }
    if (coversFrom.present) {
      map['covers_from'] = Variable<DateTime>(coversFrom.value);
    }
    if (coversTo.present) {
      map['covers_to'] = Variable<DateTime>(coversTo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchSessionsCompanion(')
          ..write('id: $id, ')
          ..write('cookedOn: $cookedOn, ')
          ..write('coversFrom: $coversFrom, ')
          ..write('coversTo: $coversTo')
          ..write(')'))
        .toString();
  }
}

class $BatchItemsTable extends BatchItems
    with TableInfo<$BatchItemsTable, BatchItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _batchSessionIdMeta = const VerificationMeta(
    'batchSessionId',
  );
  @override
  late final GeneratedColumn<int> batchSessionId = GeneratedColumn<int>(
    'batch_session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batch_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _rawTotalGMeta = const VerificationMeta(
    'rawTotalG',
  );
  @override
  late final GeneratedColumn<double> rawTotalG = GeneratedColumn<double>(
    'raw_total_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cookedTotalGMeta = const VerificationMeta(
    'cookedTotalG',
  );
  @override
  late final GeneratedColumn<double> cookedTotalG = GeneratedColumn<double>(
    'cooked_total_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchSessionId,
    recipeId,
    rawTotalG,
    cookedTotalG,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batch_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatchItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('batch_session_id')) {
      context.handle(
        _batchSessionIdMeta,
        batchSessionId.isAcceptableOrUnknown(
          data['batch_session_id']!,
          _batchSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_batchSessionIdMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('raw_total_g')) {
      context.handle(
        _rawTotalGMeta,
        rawTotalG.isAcceptableOrUnknown(data['raw_total_g']!, _rawTotalGMeta),
      );
    } else if (isInserting) {
      context.missing(_rawTotalGMeta);
    }
    if (data.containsKey('cooked_total_g')) {
      context.handle(
        _cookedTotalGMeta,
        cookedTotalG.isAcceptableOrUnknown(
          data['cooked_total_g']!,
          _cookedTotalGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cookedTotalGMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BatchItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatchItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      batchSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}batch_session_id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      rawTotalG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}raw_total_g'],
      )!,
      cookedTotalG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cooked_total_g'],
      )!,
    );
  }

  @override
  $BatchItemsTable createAlias(String alias) {
    return $BatchItemsTable(attachedDatabase, alias);
  }
}

class BatchItem extends DataClass implements Insertable<BatchItem> {
  final int id;
  final int batchSessionId;
  final int recipeId;
  final double rawTotalG;
  final double cookedTotalG;
  const BatchItem({
    required this.id,
    required this.batchSessionId,
    required this.recipeId,
    required this.rawTotalG,
    required this.cookedTotalG,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['batch_session_id'] = Variable<int>(batchSessionId);
    map['recipe_id'] = Variable<int>(recipeId);
    map['raw_total_g'] = Variable<double>(rawTotalG);
    map['cooked_total_g'] = Variable<double>(cookedTotalG);
    return map;
  }

  BatchItemsCompanion toCompanion(bool nullToAbsent) {
    return BatchItemsCompanion(
      id: Value(id),
      batchSessionId: Value(batchSessionId),
      recipeId: Value(recipeId),
      rawTotalG: Value(rawTotalG),
      cookedTotalG: Value(cookedTotalG),
    );
  }

  factory BatchItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatchItem(
      id: serializer.fromJson<int>(json['id']),
      batchSessionId: serializer.fromJson<int>(json['batchSessionId']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      rawTotalG: serializer.fromJson<double>(json['rawTotalG']),
      cookedTotalG: serializer.fromJson<double>(json['cookedTotalG']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'batchSessionId': serializer.toJson<int>(batchSessionId),
      'recipeId': serializer.toJson<int>(recipeId),
      'rawTotalG': serializer.toJson<double>(rawTotalG),
      'cookedTotalG': serializer.toJson<double>(cookedTotalG),
    };
  }

  BatchItem copyWith({
    int? id,
    int? batchSessionId,
    int? recipeId,
    double? rawTotalG,
    double? cookedTotalG,
  }) => BatchItem(
    id: id ?? this.id,
    batchSessionId: batchSessionId ?? this.batchSessionId,
    recipeId: recipeId ?? this.recipeId,
    rawTotalG: rawTotalG ?? this.rawTotalG,
    cookedTotalG: cookedTotalG ?? this.cookedTotalG,
  );
  BatchItem copyWithCompanion(BatchItemsCompanion data) {
    return BatchItem(
      id: data.id.present ? data.id.value : this.id,
      batchSessionId: data.batchSessionId.present
          ? data.batchSessionId.value
          : this.batchSessionId,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      rawTotalG: data.rawTotalG.present ? data.rawTotalG.value : this.rawTotalG,
      cookedTotalG: data.cookedTotalG.present
          ? data.cookedTotalG.value
          : this.cookedTotalG,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatchItem(')
          ..write('id: $id, ')
          ..write('batchSessionId: $batchSessionId, ')
          ..write('recipeId: $recipeId, ')
          ..write('rawTotalG: $rawTotalG, ')
          ..write('cookedTotalG: $cookedTotalG')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, batchSessionId, recipeId, rawTotalG, cookedTotalG);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatchItem &&
          other.id == this.id &&
          other.batchSessionId == this.batchSessionId &&
          other.recipeId == this.recipeId &&
          other.rawTotalG == this.rawTotalG &&
          other.cookedTotalG == this.cookedTotalG);
}

class BatchItemsCompanion extends UpdateCompanion<BatchItem> {
  final Value<int> id;
  final Value<int> batchSessionId;
  final Value<int> recipeId;
  final Value<double> rawTotalG;
  final Value<double> cookedTotalG;
  const BatchItemsCompanion({
    this.id = const Value.absent(),
    this.batchSessionId = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.rawTotalG = const Value.absent(),
    this.cookedTotalG = const Value.absent(),
  });
  BatchItemsCompanion.insert({
    this.id = const Value.absent(),
    required int batchSessionId,
    required int recipeId,
    required double rawTotalG,
    required double cookedTotalG,
  }) : batchSessionId = Value(batchSessionId),
       recipeId = Value(recipeId),
       rawTotalG = Value(rawTotalG),
       cookedTotalG = Value(cookedTotalG);
  static Insertable<BatchItem> custom({
    Expression<int>? id,
    Expression<int>? batchSessionId,
    Expression<int>? recipeId,
    Expression<double>? rawTotalG,
    Expression<double>? cookedTotalG,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchSessionId != null) 'batch_session_id': batchSessionId,
      if (recipeId != null) 'recipe_id': recipeId,
      if (rawTotalG != null) 'raw_total_g': rawTotalG,
      if (cookedTotalG != null) 'cooked_total_g': cookedTotalG,
    });
  }

  BatchItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? batchSessionId,
    Value<int>? recipeId,
    Value<double>? rawTotalG,
    Value<double>? cookedTotalG,
  }) {
    return BatchItemsCompanion(
      id: id ?? this.id,
      batchSessionId: batchSessionId ?? this.batchSessionId,
      recipeId: recipeId ?? this.recipeId,
      rawTotalG: rawTotalG ?? this.rawTotalG,
      cookedTotalG: cookedTotalG ?? this.cookedTotalG,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (batchSessionId.present) {
      map['batch_session_id'] = Variable<int>(batchSessionId.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (rawTotalG.present) {
      map['raw_total_g'] = Variable<double>(rawTotalG.value);
    }
    if (cookedTotalG.present) {
      map['cooked_total_g'] = Variable<double>(cookedTotalG.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchItemsCompanion(')
          ..write('id: $id, ')
          ..write('batchSessionId: $batchSessionId, ')
          ..write('recipeId: $recipeId, ')
          ..write('rawTotalG: $rawTotalG, ')
          ..write('cookedTotalG: $cookedTotalG')
          ..write(')'))
        .toString();
  }
}

class $MealLogsTable extends MealLogs with TableInfo<$MealLogsTable, MealLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    check: () => ComparableExpr(slot).isBetweenValues(1, 3),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DayType, String> dayType =
      GeneratedColumn<String>(
        'day_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DayType>($MealLogsTable.$converterdayType);
  @override
  List<GeneratedColumn> get $columns => [id, date, slot, dayType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {date, slot},
  ];
  @override
  MealLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      dayType: $MealLogsTable.$converterdayType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}day_type'],
        )!,
      ),
    );
  }

  @override
  $MealLogsTable createAlias(String alias) {
    return $MealLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DayType, String, String> $converterdayType =
      const EnumNameConverter<DayType>(DayType.values);
}

class MealLog extends DataClass implements Insertable<MealLog> {
  final int id;

  /// Local midnight of the calendar day (see `dateOnly`).
  final DateTime date;
  final int slot;

  /// Day type snapshot taken when the meal was logged.
  final DayType dayType;
  const MealLog({
    required this.id,
    required this.date,
    required this.slot,
    required this.dayType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['slot'] = Variable<int>(slot);
    {
      map['day_type'] = Variable<String>(
        $MealLogsTable.$converterdayType.toSql(dayType),
      );
    }
    return map;
  }

  MealLogsCompanion toCompanion(bool nullToAbsent) {
    return MealLogsCompanion(
      id: Value(id),
      date: Value(date),
      slot: Value(slot),
      dayType: Value(dayType),
    );
  }

  factory MealLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      slot: serializer.fromJson<int>(json['slot']),
      dayType: $MealLogsTable.$converterdayType.fromJson(
        serializer.fromJson<String>(json['dayType']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'slot': serializer.toJson<int>(slot),
      'dayType': serializer.toJson<String>(
        $MealLogsTable.$converterdayType.toJson(dayType),
      ),
    };
  }

  MealLog copyWith({int? id, DateTime? date, int? slot, DayType? dayType}) =>
      MealLog(
        id: id ?? this.id,
        date: date ?? this.date,
        slot: slot ?? this.slot,
        dayType: dayType ?? this.dayType,
      );
  MealLog copyWithCompanion(MealLogsCompanion data) {
    return MealLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      slot: data.slot.present ? data.slot.value : this.slot,
      dayType: data.dayType.present ? data.dayType.value : this.dayType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('slot: $slot, ')
          ..write('dayType: $dayType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, slot, dayType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.slot == this.slot &&
          other.dayType == this.dayType);
}

class MealLogsCompanion extends UpdateCompanion<MealLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> slot;
  final Value<DayType> dayType;
  const MealLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.slot = const Value.absent(),
    this.dayType = const Value.absent(),
  });
  MealLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int slot,
    required DayType dayType,
  }) : date = Value(date),
       slot = Value(slot),
       dayType = Value(dayType);
  static Insertable<MealLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? slot,
    Expression<String>? dayType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (slot != null) 'slot': slot,
      if (dayType != null) 'day_type': dayType,
    });
  }

  MealLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? slot,
    Value<DayType>? dayType,
  }) {
    return MealLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      slot: slot ?? this.slot,
      dayType: dayType ?? this.dayType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (dayType.present) {
      map['day_type'] = Variable<String>(
        $MealLogsTable.$converterdayType.toSql(dayType.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('slot: $slot, ')
          ..write('dayType: $dayType')
          ..write(')'))
        .toString();
  }
}

class $MealComponentsTable extends MealComponents
    with TableInfo<$MealComponentsTable, MealComponent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealComponentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _mealLogIdMeta = const VerificationMeta(
    'mealLogId',
  );
  @override
  late final GeneratedColumn<int> mealLogId = GeneratedColumn<int>(
    'meal_log_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meal_logs (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _batchItemIdMeta = const VerificationMeta(
    'batchItemId',
  );
  @override
  late final GeneratedColumn<int> batchItemId = GeneratedColumn<int>(
    'batch_item_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES batch_items (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _gramsMeta = const VerificationMeta('grams');
  @override
  late final GeneratedColumn<double> grams = GeneratedColumn<double>(
    'grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealLogId,
    batchItemId,
    ingredientId,
    grams,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_components';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealComponent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_log_id')) {
      context.handle(
        _mealLogIdMeta,
        mealLogId.isAcceptableOrUnknown(data['meal_log_id']!, _mealLogIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mealLogIdMeta);
    }
    if (data.containsKey('batch_item_id')) {
      context.handle(
        _batchItemIdMeta,
        batchItemId.isAcceptableOrUnknown(
          data['batch_item_id']!,
          _batchItemIdMeta,
        ),
      );
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    }
    if (data.containsKey('grams')) {
      context.handle(
        _gramsMeta,
        grams.isAcceptableOrUnknown(data['grams']!, _gramsMeta),
      );
    } else if (isInserting) {
      context.missing(_gramsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealComponent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealComponent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      mealLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meal_log_id'],
      )!,
      batchItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}batch_item_id'],
      ),
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      ),
      grams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grams'],
      )!,
    );
  }

  @override
  $MealComponentsTable createAlias(String alias) {
    return $MealComponentsTable(attachedDatabase, alias);
  }
}

class MealComponent extends DataClass implements Insertable<MealComponent> {
  final int id;
  final int mealLogId;
  final int? batchItemId;
  final int? ingredientId;
  final double grams;
  const MealComponent({
    required this.id,
    required this.mealLogId,
    this.batchItemId,
    this.ingredientId,
    required this.grams,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_log_id'] = Variable<int>(mealLogId);
    if (!nullToAbsent || batchItemId != null) {
      map['batch_item_id'] = Variable<int>(batchItemId);
    }
    if (!nullToAbsent || ingredientId != null) {
      map['ingredient_id'] = Variable<int>(ingredientId);
    }
    map['grams'] = Variable<double>(grams);
    return map;
  }

  MealComponentsCompanion toCompanion(bool nullToAbsent) {
    return MealComponentsCompanion(
      id: Value(id),
      mealLogId: Value(mealLogId),
      batchItemId: batchItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(batchItemId),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      grams: Value(grams),
    );
  }

  factory MealComponent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealComponent(
      id: serializer.fromJson<int>(json['id']),
      mealLogId: serializer.fromJson<int>(json['mealLogId']),
      batchItemId: serializer.fromJson<int?>(json['batchItemId']),
      ingredientId: serializer.fromJson<int?>(json['ingredientId']),
      grams: serializer.fromJson<double>(json['grams']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealLogId': serializer.toJson<int>(mealLogId),
      'batchItemId': serializer.toJson<int?>(batchItemId),
      'ingredientId': serializer.toJson<int?>(ingredientId),
      'grams': serializer.toJson<double>(grams),
    };
  }

  MealComponent copyWith({
    int? id,
    int? mealLogId,
    Value<int?> batchItemId = const Value.absent(),
    Value<int?> ingredientId = const Value.absent(),
    double? grams,
  }) => MealComponent(
    id: id ?? this.id,
    mealLogId: mealLogId ?? this.mealLogId,
    batchItemId: batchItemId.present ? batchItemId.value : this.batchItemId,
    ingredientId: ingredientId.present ? ingredientId.value : this.ingredientId,
    grams: grams ?? this.grams,
  );
  MealComponent copyWithCompanion(MealComponentsCompanion data) {
    return MealComponent(
      id: data.id.present ? data.id.value : this.id,
      mealLogId: data.mealLogId.present ? data.mealLogId.value : this.mealLogId,
      batchItemId: data.batchItemId.present
          ? data.batchItemId.value
          : this.batchItemId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      grams: data.grams.present ? data.grams.value : this.grams,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealComponent(')
          ..write('id: $id, ')
          ..write('mealLogId: $mealLogId, ')
          ..write('batchItemId: $batchItemId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('grams: $grams')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, mealLogId, batchItemId, ingredientId, grams);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealComponent &&
          other.id == this.id &&
          other.mealLogId == this.mealLogId &&
          other.batchItemId == this.batchItemId &&
          other.ingredientId == this.ingredientId &&
          other.grams == this.grams);
}

class MealComponentsCompanion extends UpdateCompanion<MealComponent> {
  final Value<int> id;
  final Value<int> mealLogId;
  final Value<int?> batchItemId;
  final Value<int?> ingredientId;
  final Value<double> grams;
  const MealComponentsCompanion({
    this.id = const Value.absent(),
    this.mealLogId = const Value.absent(),
    this.batchItemId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.grams = const Value.absent(),
  });
  MealComponentsCompanion.insert({
    this.id = const Value.absent(),
    required int mealLogId,
    this.batchItemId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    required double grams,
  }) : mealLogId = Value(mealLogId),
       grams = Value(grams);
  static Insertable<MealComponent> custom({
    Expression<int>? id,
    Expression<int>? mealLogId,
    Expression<int>? batchItemId,
    Expression<int>? ingredientId,
    Expression<double>? grams,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealLogId != null) 'meal_log_id': mealLogId,
      if (batchItemId != null) 'batch_item_id': batchItemId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (grams != null) 'grams': grams,
    });
  }

  MealComponentsCompanion copyWith({
    Value<int>? id,
    Value<int>? mealLogId,
    Value<int?>? batchItemId,
    Value<int?>? ingredientId,
    Value<double>? grams,
  }) {
    return MealComponentsCompanion(
      id: id ?? this.id,
      mealLogId: mealLogId ?? this.mealLogId,
      batchItemId: batchItemId ?? this.batchItemId,
      ingredientId: ingredientId ?? this.ingredientId,
      grams: grams ?? this.grams,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealLogId.present) {
      map['meal_log_id'] = Variable<int>(mealLogId.value);
    }
    if (batchItemId.present) {
      map['batch_item_id'] = Variable<int>(batchItemId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (grams.present) {
      map['grams'] = Variable<double>(grams.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealComponentsCompanion(')
          ..write('id: $id, ')
          ..write('mealLogId: $mealLogId, ')
          ..write('batchItemId: $batchItemId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('grams: $grams')
          ..write(')'))
        .toString();
  }
}

class $HydrationLogsTable extends HydrationLogs
    with TableInfo<$HydrationLogsTable, HydrationLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HydrationLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mlMeta = const VerificationMeta('ml');
  @override
  late final GeneratedColumn<int> ml = GeneratedColumn<int>(
    'ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, ml, loggedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hydration_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HydrationLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('ml')) {
      context.handle(_mlMeta, ml.isAcceptableOrUnknown(data['ml']!, _mlMeta));
    } else if (isInserting) {
      context.missing(_mlMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HydrationLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HydrationLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      ml: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ml'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $HydrationLogsTable createAlias(String alias) {
    return $HydrationLogsTable(attachedDatabase, alias);
  }
}

class HydrationLog extends DataClass implements Insertable<HydrationLog> {
  final int id;
  final DateTime date;
  final int ml;
  final DateTime loggedAt;
  const HydrationLog({
    required this.id,
    required this.date,
    required this.ml,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['ml'] = Variable<int>(ml);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  HydrationLogsCompanion toCompanion(bool nullToAbsent) {
    return HydrationLogsCompanion(
      id: Value(id),
      date: Value(date),
      ml: Value(ml),
      loggedAt: Value(loggedAt),
    );
  }

  factory HydrationLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HydrationLog(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      ml: serializer.fromJson<int>(json['ml']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'ml': serializer.toJson<int>(ml),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  HydrationLog copyWith({
    int? id,
    DateTime? date,
    int? ml,
    DateTime? loggedAt,
  }) => HydrationLog(
    id: id ?? this.id,
    date: date ?? this.date,
    ml: ml ?? this.ml,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  HydrationLog copyWithCompanion(HydrationLogsCompanion data) {
    return HydrationLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      ml: data.ml.present ? data.ml.value : this.ml,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HydrationLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('ml: $ml, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, ml, loggedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HydrationLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.ml == this.ml &&
          other.loggedAt == this.loggedAt);
}

class HydrationLogsCompanion extends UpdateCompanion<HydrationLog> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> ml;
  final Value<DateTime> loggedAt;
  const HydrationLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.ml = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  HydrationLogsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int ml,
    this.loggedAt = const Value.absent(),
  }) : date = Value(date),
       ml = Value(ml);
  static Insertable<HydrationLog> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? ml,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (ml != null) 'ml': ml,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  HydrationLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? ml,
    Value<DateTime>? loggedAt,
  }) {
    return HydrationLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      ml: ml ?? this.ml,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (ml.present) {
      map['ml'] = Variable<int>(ml.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HydrationLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('ml: $ml, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $DayLogsTable extends DayLogs with TableInfo<$DayLogsTable, DayLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fruitPortionsMeta = const VerificationMeta(
    'fruitPortions',
  );
  @override
  late final GeneratedColumn<int> fruitPortions = GeneratedColumn<int>(
    'fruit_portions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vegPortionsMeta = const VerificationMeta(
    'vegPortions',
  );
  @override
  late final GeneratedColumn<int> vegPortions = GeneratedColumn<int>(
    'veg_portions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [date, fruitPortions, vegPortions];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('fruit_portions')) {
      context.handle(
        _fruitPortionsMeta,
        fruitPortions.isAcceptableOrUnknown(
          data['fruit_portions']!,
          _fruitPortionsMeta,
        ),
      );
    }
    if (data.containsKey('veg_portions')) {
      context.handle(
        _vegPortionsMeta,
        vegPortions.isAcceptableOrUnknown(
          data['veg_portions']!,
          _vegPortionsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DayLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayLog(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      fruitPortions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fruit_portions'],
      )!,
      vegPortions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}veg_portions'],
      )!,
    );
  }

  @override
  $DayLogsTable createAlias(String alias) {
    return $DayLogsTable(attachedDatabase, alias);
  }
}

class DayLog extends DataClass implements Insertable<DayLog> {
  /// Local midnight of the calendar day (see `dateOnly`).
  final DateTime date;
  final int fruitPortions;
  final int vegPortions;
  const DayLog({
    required this.date,
    required this.fruitPortions,
    required this.vegPortions,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<DateTime>(date);
    map['fruit_portions'] = Variable<int>(fruitPortions);
    map['veg_portions'] = Variable<int>(vegPortions);
    return map;
  }

  DayLogsCompanion toCompanion(bool nullToAbsent) {
    return DayLogsCompanion(
      date: Value(date),
      fruitPortions: Value(fruitPortions),
      vegPortions: Value(vegPortions),
    );
  }

  factory DayLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayLog(
      date: serializer.fromJson<DateTime>(json['date']),
      fruitPortions: serializer.fromJson<int>(json['fruitPortions']),
      vegPortions: serializer.fromJson<int>(json['vegPortions']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<DateTime>(date),
      'fruitPortions': serializer.toJson<int>(fruitPortions),
      'vegPortions': serializer.toJson<int>(vegPortions),
    };
  }

  DayLog copyWith({DateTime? date, int? fruitPortions, int? vegPortions}) =>
      DayLog(
        date: date ?? this.date,
        fruitPortions: fruitPortions ?? this.fruitPortions,
        vegPortions: vegPortions ?? this.vegPortions,
      );
  DayLog copyWithCompanion(DayLogsCompanion data) {
    return DayLog(
      date: data.date.present ? data.date.value : this.date,
      fruitPortions: data.fruitPortions.present
          ? data.fruitPortions.value
          : this.fruitPortions,
      vegPortions: data.vegPortions.present
          ? data.vegPortions.value
          : this.vegPortions,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayLog(')
          ..write('date: $date, ')
          ..write('fruitPortions: $fruitPortions, ')
          ..write('vegPortions: $vegPortions')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, fruitPortions, vegPortions);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayLog &&
          other.date == this.date &&
          other.fruitPortions == this.fruitPortions &&
          other.vegPortions == this.vegPortions);
}

class DayLogsCompanion extends UpdateCompanion<DayLog> {
  final Value<DateTime> date;
  final Value<int> fruitPortions;
  final Value<int> vegPortions;
  final Value<int> rowid;
  const DayLogsCompanion({
    this.date = const Value.absent(),
    this.fruitPortions = const Value.absent(),
    this.vegPortions = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DayLogsCompanion.insert({
    required DateTime date,
    this.fruitPortions = const Value.absent(),
    this.vegPortions = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DayLog> custom({
    Expression<DateTime>? date,
    Expression<int>? fruitPortions,
    Expression<int>? vegPortions,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (fruitPortions != null) 'fruit_portions': fruitPortions,
      if (vegPortions != null) 'veg_portions': vegPortions,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DayLogsCompanion copyWith({
    Value<DateTime>? date,
    Value<int>? fruitPortions,
    Value<int>? vegPortions,
    Value<int>? rowid,
  }) {
    return DayLogsCompanion(
      date: date ?? this.date,
      fruitPortions: fruitPortions ?? this.fruitPortions,
      vegPortions: vegPortions ?? this.vegPortions,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (fruitPortions.present) {
      map['fruit_portions'] = Variable<int>(fruitPortions.value);
    }
    if (vegPortions.present) {
      map['veg_portions'] = Variable<int>(vegPortions.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayLogsCompanion(')
          ..write('date: $date, ')
          ..write('fruitPortions: $fruitPortions, ')
          ..write('vegPortions: $vegPortions, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $DayTypeTargetRowsTable dayTypeTargetRows =
      $DayTypeTargetRowsTable(this);
  late final $WeekScheduleEntriesTable weekScheduleEntries =
      $WeekScheduleEntriesTable(this);
  late final $IngredientsTable ingredients = $IngredientsTable(this);
  late final $ToolsTable tools = $ToolsTable(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $RecipeIngredientsTable recipeIngredients =
      $RecipeIngredientsTable(this);
  late final $RecipeStepsTable recipeSteps = $RecipeStepsTable(this);
  late final $RecipeToolsTable recipeTools = $RecipeToolsTable(this);
  late final $BatchSessionsTable batchSessions = $BatchSessionsTable(this);
  late final $BatchItemsTable batchItems = $BatchItemsTable(this);
  late final $MealLogsTable mealLogs = $MealLogsTable(this);
  late final $MealComponentsTable mealComponents = $MealComponentsTable(this);
  late final $HydrationLogsTable hydrationLogs = $HydrationLogsTable(this);
  late final $DayLogsTable dayLogs = $DayLogsTable(this);
  late final TargetsDao targetsDao = TargetsDao(this as AppDatabase);
  late final RecipesDao recipesDao = RecipesDao(this as AppDatabase);
  late final InventoryDao inventoryDao = InventoryDao(this as AppDatabase);
  late final MealLogDao mealLogDao = MealLogDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    dayTypeTargetRows,
    weekScheduleEntries,
    ingredients,
    tools,
    recipes,
    recipeIngredients,
    recipeSteps,
    recipeTools,
    batchSessions,
    batchItems,
    mealLogs,
    mealComponents,
    hydrationLogs,
    dayLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_ingredients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tools',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_steps', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_tools', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tools',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_tools', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'batch_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('batch_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meal_logs',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meal_components', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<double?> bodyWeightKg,
      required double proteinGPerDay,
      required double fatGPerDay,
      required int mealsPerDay,
      required double proteinPerMealMin,
      required double proteinPerMealMax,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<double?> bodyWeightKg,
      Value<double> proteinGPerDay,
      Value<double> fatGPerDay,
      Value<int> mealsPerDay,
      Value<double> proteinPerMealMin,
      Value<double> proteinPerMealMax,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyWeightKg => $composableBuilder(
    column: $table.bodyWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinGPerDay => $composableBuilder(
    column: $table.proteinGPerDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatGPerDay => $composableBuilder(
    column: $table.fatGPerDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mealsPerDay => $composableBuilder(
    column: $table.mealsPerDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPerMealMin => $composableBuilder(
    column: $table.proteinPerMealMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPerMealMax => $composableBuilder(
    column: $table.proteinPerMealMax,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyWeightKg => $composableBuilder(
    column: $table.bodyWeightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinGPerDay => $composableBuilder(
    column: $table.proteinGPerDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatGPerDay => $composableBuilder(
    column: $table.fatGPerDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mealsPerDay => $composableBuilder(
    column: $table.mealsPerDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPerMealMin => $composableBuilder(
    column: $table.proteinPerMealMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPerMealMax => $composableBuilder(
    column: $table.proteinPerMealMax,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get bodyWeightKg => $composableBuilder(
    column: $table.bodyWeightKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinGPerDay => $composableBuilder(
    column: $table.proteinGPerDay,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatGPerDay => $composableBuilder(
    column: $table.fatGPerDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mealsPerDay => $composableBuilder(
    column: $table.mealsPerDay,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPerMealMin => $composableBuilder(
    column: $table.proteinPerMealMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPerMealMax => $composableBuilder(
    column: $table.proteinPerMealMax,
    builder: (column) => column,
  );
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double?> bodyWeightKg = const Value.absent(),
                Value<double> proteinGPerDay = const Value.absent(),
                Value<double> fatGPerDay = const Value.absent(),
                Value<int> mealsPerDay = const Value.absent(),
                Value<double> proteinPerMealMin = const Value.absent(),
                Value<double> proteinPerMealMax = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                bodyWeightKg: bodyWeightKg,
                proteinGPerDay: proteinGPerDay,
                fatGPerDay: fatGPerDay,
                mealsPerDay: mealsPerDay,
                proteinPerMealMin: proteinPerMealMin,
                proteinPerMealMax: proteinPerMealMax,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double?> bodyWeightKg = const Value.absent(),
                required double proteinGPerDay,
                required double fatGPerDay,
                required int mealsPerDay,
                required double proteinPerMealMin,
                required double proteinPerMealMax,
              }) => UserProfilesCompanion.insert(
                id: id,
                bodyWeightKg: bodyWeightKg,
                proteinGPerDay: proteinGPerDay,
                fatGPerDay: fatGPerDay,
                mealsPerDay: mealsPerDay,
                proteinPerMealMin: proteinPerMealMin,
                proteinPerMealMax: proteinPerMealMax,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserProfilesTable, UserProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserProfilesTable,
                    UserProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$DayTypeTargetRowsTableCreateCompanionBuilder =
    DayTypeTargetRowsCompanion Function({
      required DayType dayType,
      required double kcalMin,
      required double kcalMax,
      required double carbsMin,
      required double carbsMax,
      required double fiberMin,
      required double fiberMax,
      required double waterMlMin,
      required double waterMlMax,
      required double fruitMin,
      required double fruitMax,
      required double vegMin,
      required double vegMax,
      Value<int> rowid,
    });
typedef $$DayTypeTargetRowsTableUpdateCompanionBuilder =
    DayTypeTargetRowsCompanion Function({
      Value<DayType> dayType,
      Value<double> kcalMin,
      Value<double> kcalMax,
      Value<double> carbsMin,
      Value<double> carbsMax,
      Value<double> fiberMin,
      Value<double> fiberMax,
      Value<double> waterMlMin,
      Value<double> waterMlMax,
      Value<double> fruitMin,
      Value<double> fruitMax,
      Value<double> vegMin,
      Value<double> vegMax,
      Value<int> rowid,
    });

class $$DayTypeTargetRowsTableFilterComposer
    extends Composer<_$AppDatabase, $DayTypeTargetRowsTable> {
  $$DayTypeTargetRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<DayType, DayType, String> get dayType =>
      $composableBuilder(
        column: $table.dayType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get kcalMin => $composableBuilder(
    column: $table.kcalMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcalMax => $composableBuilder(
    column: $table.kcalMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsMin => $composableBuilder(
    column: $table.carbsMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsMax => $composableBuilder(
    column: $table.carbsMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiberMin => $composableBuilder(
    column: $table.fiberMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiberMax => $composableBuilder(
    column: $table.fiberMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterMlMin => $composableBuilder(
    column: $table.waterMlMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterMlMax => $composableBuilder(
    column: $table.waterMlMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fruitMin => $composableBuilder(
    column: $table.fruitMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fruitMax => $composableBuilder(
    column: $table.fruitMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vegMin => $composableBuilder(
    column: $table.vegMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vegMax => $composableBuilder(
    column: $table.vegMax,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DayTypeTargetRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $DayTypeTargetRowsTable> {
  $$DayTypeTargetRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dayType => $composableBuilder(
    column: $table.dayType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalMin => $composableBuilder(
    column: $table.kcalMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcalMax => $composableBuilder(
    column: $table.kcalMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsMin => $composableBuilder(
    column: $table.carbsMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsMax => $composableBuilder(
    column: $table.carbsMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiberMin => $composableBuilder(
    column: $table.fiberMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiberMax => $composableBuilder(
    column: $table.fiberMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterMlMin => $composableBuilder(
    column: $table.waterMlMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterMlMax => $composableBuilder(
    column: $table.waterMlMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fruitMin => $composableBuilder(
    column: $table.fruitMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fruitMax => $composableBuilder(
    column: $table.fruitMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vegMin => $composableBuilder(
    column: $table.vegMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vegMax => $composableBuilder(
    column: $table.vegMax,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DayTypeTargetRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayTypeTargetRowsTable> {
  $$DayTypeTargetRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<DayType, String> get dayType =>
      $composableBuilder(column: $table.dayType, builder: (column) => column);

  GeneratedColumn<double> get kcalMin =>
      $composableBuilder(column: $table.kcalMin, builder: (column) => column);

  GeneratedColumn<double> get kcalMax =>
      $composableBuilder(column: $table.kcalMax, builder: (column) => column);

  GeneratedColumn<double> get carbsMin =>
      $composableBuilder(column: $table.carbsMin, builder: (column) => column);

  GeneratedColumn<double> get carbsMax =>
      $composableBuilder(column: $table.carbsMax, builder: (column) => column);

  GeneratedColumn<double> get fiberMin =>
      $composableBuilder(column: $table.fiberMin, builder: (column) => column);

  GeneratedColumn<double> get fiberMax =>
      $composableBuilder(column: $table.fiberMax, builder: (column) => column);

  GeneratedColumn<double> get waterMlMin => $composableBuilder(
    column: $table.waterMlMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waterMlMax => $composableBuilder(
    column: $table.waterMlMax,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fruitMin =>
      $composableBuilder(column: $table.fruitMin, builder: (column) => column);

  GeneratedColumn<double> get fruitMax =>
      $composableBuilder(column: $table.fruitMax, builder: (column) => column);

  GeneratedColumn<double> get vegMin =>
      $composableBuilder(column: $table.vegMin, builder: (column) => column);

  GeneratedColumn<double> get vegMax =>
      $composableBuilder(column: $table.vegMax, builder: (column) => column);
}

class $$DayTypeTargetRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayTypeTargetRowsTable,
          DayTypeTargetRow,
          $$DayTypeTargetRowsTableFilterComposer,
          $$DayTypeTargetRowsTableOrderingComposer,
          $$DayTypeTargetRowsTableAnnotationComposer,
          $$DayTypeTargetRowsTableCreateCompanionBuilder,
          $$DayTypeTargetRowsTableUpdateCompanionBuilder,
          (
            DayTypeTargetRow,
            BaseReferences<
              _$AppDatabase,
              $DayTypeTargetRowsTable,
              DayTypeTargetRow
            >,
          ),
          DayTypeTargetRow,
          PrefetchHooks Function()
        > {
  $$DayTypeTargetRowsTableTableManager(
    _$AppDatabase db,
    $DayTypeTargetRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayTypeTargetRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayTypeTargetRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayTypeTargetRowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DayType> dayType = const Value.absent(),
                Value<double> kcalMin = const Value.absent(),
                Value<double> kcalMax = const Value.absent(),
                Value<double> carbsMin = const Value.absent(),
                Value<double> carbsMax = const Value.absent(),
                Value<double> fiberMin = const Value.absent(),
                Value<double> fiberMax = const Value.absent(),
                Value<double> waterMlMin = const Value.absent(),
                Value<double> waterMlMax = const Value.absent(),
                Value<double> fruitMin = const Value.absent(),
                Value<double> fruitMax = const Value.absent(),
                Value<double> vegMin = const Value.absent(),
                Value<double> vegMax = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayTypeTargetRowsCompanion(
                dayType: dayType,
                kcalMin: kcalMin,
                kcalMax: kcalMax,
                carbsMin: carbsMin,
                carbsMax: carbsMax,
                fiberMin: fiberMin,
                fiberMax: fiberMax,
                waterMlMin: waterMlMin,
                waterMlMax: waterMlMax,
                fruitMin: fruitMin,
                fruitMax: fruitMax,
                vegMin: vegMin,
                vegMax: vegMax,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DayType dayType,
                required double kcalMin,
                required double kcalMax,
                required double carbsMin,
                required double carbsMax,
                required double fiberMin,
                required double fiberMax,
                required double waterMlMin,
                required double waterMlMax,
                required double fruitMin,
                required double fruitMax,
                required double vegMin,
                required double vegMax,
                Value<int> rowid = const Value.absent(),
              }) => DayTypeTargetRowsCompanion.insert(
                dayType: dayType,
                kcalMin: kcalMin,
                kcalMax: kcalMax,
                carbsMin: carbsMin,
                carbsMax: carbsMax,
                fiberMin: fiberMin,
                fiberMax: fiberMax,
                waterMlMin: waterMlMin,
                waterMlMax: waterMlMax,
                fruitMin: fruitMin,
                fruitMax: fruitMax,
                vegMin: vegMin,
                vegMax: vegMax,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DayTypeTargetRowsTable, DayTypeTargetRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DayTypeTargetRowsTable,
                    DayTypeTargetRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DayTypeTargetRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayTypeTargetRowsTable,
      DayTypeTargetRow,
      $$DayTypeTargetRowsTableFilterComposer,
      $$DayTypeTargetRowsTableOrderingComposer,
      $$DayTypeTargetRowsTableAnnotationComposer,
      $$DayTypeTargetRowsTableCreateCompanionBuilder,
      $$DayTypeTargetRowsTableUpdateCompanionBuilder,
      (
        DayTypeTargetRow,
        BaseReferences<
          _$AppDatabase,
          $DayTypeTargetRowsTable,
          DayTypeTargetRow
        >,
      ),
      DayTypeTargetRow,
      PrefetchHooks Function()
    >;
typedef $$WeekScheduleEntriesTableCreateCompanionBuilder =
    WeekScheduleEntriesCompanion Function({
      Value<int> weekday,
      required DayType dayType,
    });
typedef $$WeekScheduleEntriesTableUpdateCompanionBuilder =
    WeekScheduleEntriesCompanion Function({
      Value<int> weekday,
      Value<DayType> dayType,
    });

class $$WeekScheduleEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WeekScheduleEntriesTable> {
  $$WeekScheduleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DayType, DayType, String> get dayType =>
      $composableBuilder(
        column: $table.dayType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$WeekScheduleEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WeekScheduleEntriesTable> {
  $$WeekScheduleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dayType => $composableBuilder(
    column: $table.dayType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeekScheduleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeekScheduleEntriesTable> {
  $$WeekScheduleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DayType, String> get dayType =>
      $composableBuilder(column: $table.dayType, builder: (column) => column);
}

class $$WeekScheduleEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeekScheduleEntriesTable,
          WeekScheduleEntry,
          $$WeekScheduleEntriesTableFilterComposer,
          $$WeekScheduleEntriesTableOrderingComposer,
          $$WeekScheduleEntriesTableAnnotationComposer,
          $$WeekScheduleEntriesTableCreateCompanionBuilder,
          $$WeekScheduleEntriesTableUpdateCompanionBuilder,
          (
            WeekScheduleEntry,
            BaseReferences<
              _$AppDatabase,
              $WeekScheduleEntriesTable,
              WeekScheduleEntry
            >,
          ),
          WeekScheduleEntry,
          PrefetchHooks Function()
        > {
  $$WeekScheduleEntriesTableTableManager(
    _$AppDatabase db,
    $WeekScheduleEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeekScheduleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeekScheduleEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WeekScheduleEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> weekday = const Value.absent(),
                Value<DayType> dayType = const Value.absent(),
              }) => WeekScheduleEntriesCompanion(
                weekday: weekday,
                dayType: dayType,
              ),
          createCompanionCallback:
              ({
                Value<int> weekday = const Value.absent(),
                required DayType dayType,
              }) => WeekScheduleEntriesCompanion.insert(
                weekday: weekday,
                dayType: dayType,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeekScheduleEntriesTable, WeekScheduleEntry>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $WeekScheduleEntriesTable,
                    WeekScheduleEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeekScheduleEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeekScheduleEntriesTable,
      WeekScheduleEntry,
      $$WeekScheduleEntriesTableFilterComposer,
      $$WeekScheduleEntriesTableOrderingComposer,
      $$WeekScheduleEntriesTableAnnotationComposer,
      $$WeekScheduleEntriesTableCreateCompanionBuilder,
      $$WeekScheduleEntriesTableUpdateCompanionBuilder,
      (
        WeekScheduleEntry,
        BaseReferences<
          _$AppDatabase,
          $WeekScheduleEntriesTable,
          WeekScheduleEntry
        >,
      ),
      WeekScheduleEntry,
      PrefetchHooks Function()
    >;
typedef $$IngredientsTableCreateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      required String name,
      required String category,
      Value<bool> isFruit,
      Value<bool> isVegetable,
      Value<double?> servingG,
      required double kcal100,
      required double protein100,
      required double fat100,
      required double carbs100,
      required double fiber100,
    });
typedef $$IngredientsTableUpdateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<bool> isFruit,
      Value<bool> isVegetable,
      Value<double?> servingG,
      Value<double> kcal100,
      Value<double> protein100,
      Value<double> fat100,
      Value<double> carbs100,
      Value<double> fiber100,
    });

final class $$IngredientsTableReferences
    extends BaseReferences<_$AppDatabase, $IngredientsTable, Ingredient> {
  $$IngredientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeIngredientsTable, List<RecipeIngredient>>
  _recipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recipeIngredients,
        aliasName: 'ingredients__id__recipe_ingredients__ingredient_id',
      );

  $$RecipeIngredientsTableProcessedTableManager get recipeIngredientsRefs {
    final manager = $$RecipeIngredientsTableTableManager(
      $_db,
      $_db.recipeIngredients,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MealComponentsTable, List<MealComponent>>
  _mealComponentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealComponents,
    aliasName: 'ingredients__id__meal_components__ingredient_id',
  );

  $$MealComponentsTableProcessedTableManager get mealComponentsRefs {
    final manager = $$MealComponentsTableTableManager(
      $_db,
      $_db.mealComponents,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealComponentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFruit => $composableBuilder(
    column: $table.isFruit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVegetable => $composableBuilder(
    column: $table.isVegetable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get servingG => $composableBuilder(
    column: $table.servingG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kcal100 => $composableBuilder(
    column: $table.kcal100,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein100 => $composableBuilder(
    column: $table.protein100,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat100 => $composableBuilder(
    column: $table.fat100,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs100 => $composableBuilder(
    column: $table.carbs100,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiber100 => $composableBuilder(
    column: $table.fiber100,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeIngredientsRefs(
    Expression<bool> Function($$RecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredients,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mealComponentsRefs(
    Expression<bool> Function($$MealComponentsTableFilterComposer f) f,
  ) {
    final $$MealComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealComponents,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealComponentsTableFilterComposer(
            $db: $db,
            $table: $db.mealComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFruit => $composableBuilder(
    column: $table.isFruit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVegetable => $composableBuilder(
    column: $table.isVegetable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get servingG => $composableBuilder(
    column: $table.servingG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kcal100 => $composableBuilder(
    column: $table.kcal100,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein100 => $composableBuilder(
    column: $table.protein100,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat100 => $composableBuilder(
    column: $table.fat100,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs100 => $composableBuilder(
    column: $table.carbs100,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiber100 => $composableBuilder(
    column: $table.fiber100,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isFruit =>
      $composableBuilder(column: $table.isFruit, builder: (column) => column);

  GeneratedColumn<bool> get isVegetable => $composableBuilder(
    column: $table.isVegetable,
    builder: (column) => column,
  );

  GeneratedColumn<double> get servingG =>
      $composableBuilder(column: $table.servingG, builder: (column) => column);

  GeneratedColumn<double> get kcal100 =>
      $composableBuilder(column: $table.kcal100, builder: (column) => column);

  GeneratedColumn<double> get protein100 => $composableBuilder(
    column: $table.protein100,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fat100 =>
      $composableBuilder(column: $table.fat100, builder: (column) => column);

  GeneratedColumn<double> get carbs100 =>
      $composableBuilder(column: $table.carbs100, builder: (column) => column);

  GeneratedColumn<double> get fiber100 =>
      $composableBuilder(column: $table.fiber100, builder: (column) => column);

  Expression<T> recipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recipeIngredients,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.recipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> mealComponentsRefs<T extends Object>(
    Expression<T> Function($$MealComponentsTableAnnotationComposer a) f,
  ) {
    final $$MealComponentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealComponents,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealComponentsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngredientsTable,
          Ingredient,
          $$IngredientsTableFilterComposer,
          $$IngredientsTableOrderingComposer,
          $$IngredientsTableAnnotationComposer,
          $$IngredientsTableCreateCompanionBuilder,
          $$IngredientsTableUpdateCompanionBuilder,
          (Ingredient, $$IngredientsTableReferences),
          Ingredient,
          PrefetchHooks Function({
            bool recipeIngredientsRefs,
            bool mealComponentsRefs,
          })
        > {
  $$IngredientsTableTableManager(_$AppDatabase db, $IngredientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isFruit = const Value.absent(),
                Value<bool> isVegetable = const Value.absent(),
                Value<double?> servingG = const Value.absent(),
                Value<double> kcal100 = const Value.absent(),
                Value<double> protein100 = const Value.absent(),
                Value<double> fat100 = const Value.absent(),
                Value<double> carbs100 = const Value.absent(),
                Value<double> fiber100 = const Value.absent(),
              }) => IngredientsCompanion(
                id: id,
                name: name,
                category: category,
                isFruit: isFruit,
                isVegetable: isVegetable,
                servingG: servingG,
                kcal100: kcal100,
                protein100: protein100,
                fat100: fat100,
                carbs100: carbs100,
                fiber100: fiber100,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String category,
                Value<bool> isFruit = const Value.absent(),
                Value<bool> isVegetable = const Value.absent(),
                Value<double?> servingG = const Value.absent(),
                required double kcal100,
                required double protein100,
                required double fat100,
                required double carbs100,
                required double fiber100,
              }) => IngredientsCompanion.insert(
                id: id,
                name: name,
                category: category,
                isFruit: isFruit,
                isVegetable: isVegetable,
                servingG: servingG,
                kcal100: kcal100,
                protein100: protein100,
                fat100: fat100,
                carbs100: carbs100,
                fiber100: fiber100,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IngredientsTable, Ingredient>(table),
                  $$IngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({recipeIngredientsRefs = false, mealComponentsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientsRefs) db.recipeIngredients,
                    if (mealComponentsRefs) db.mealComponents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeIngredientsRefs)
                        await $_getPrefetchedData<
                          Ingredient,
                          $IngredientsTable,
                          RecipeIngredient
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._recipeIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mealComponentsRefs)
                        await $_getPrefetchedData<
                          Ingredient,
                          $IngredientsTable,
                          MealComponent
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._mealComponentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).mealComponentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngredientsTable,
      Ingredient,
      $$IngredientsTableFilterComposer,
      $$IngredientsTableOrderingComposer,
      $$IngredientsTableAnnotationComposer,
      $$IngredientsTableCreateCompanionBuilder,
      $$IngredientsTableUpdateCompanionBuilder,
      (Ingredient, $$IngredientsTableReferences),
      Ingredient,
      PrefetchHooks Function({
        bool recipeIngredientsRefs,
        bool mealComponentsRefs,
      })
    >;
typedef $$ToolsTableCreateCompanionBuilder = ToolsCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$ToolsTableUpdateCompanionBuilder = ToolsCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$ToolsTableReferences
    extends BaseReferences<_$AppDatabase, $ToolsTable, Tool> {
  $$ToolsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeStepsTable, List<RecipeStep>>
  _recipeStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeSteps,
    aliasName: 'tools__id__recipe_steps__tool_id',
  );

  $$RecipeStepsTableProcessedTableManager get recipeStepsRefs {
    final manager = $$RecipeStepsTableTableManager(
      $_db,
      $_db.recipeSteps,
    ).filter((f) => f.toolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecipeToolsTable, List<RecipeTool>>
  _recipeToolsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeTools,
    aliasName: 'tools__id__recipe_tools__tool_id',
  );

  $$RecipeToolsTableProcessedTableManager get recipeToolsRefs {
    final manager = $$RecipeToolsTableTableManager(
      $_db,
      $_db.recipeTools,
    ).filter((f) => f.toolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeToolsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ToolsTableFilterComposer extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeStepsRefs(
    Expression<bool> Function($$RecipeStepsTableFilterComposer f) f,
  ) {
    final $$RecipeStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.toolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableFilterComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recipeToolsRefs(
    Expression<bool> Function($$RecipeToolsTableFilterComposer f) f,
  ) {
    final $$RecipeToolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeTools,
      getReferencedColumn: (t) => t.toolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeToolsTableFilterComposer(
            $db: $db,
            $table: $db.recipeTools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ToolsTableOrderingComposer
    extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ToolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ToolsTable> {
  $$ToolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> recipeStepsRefs<T extends Object>(
    Expression<T> Function($$RecipeStepsTableAnnotationComposer a) f,
  ) {
    final $$RecipeStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.toolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recipeToolsRefs<T extends Object>(
    Expression<T> Function($$RecipeToolsTableAnnotationComposer a) f,
  ) {
    final $$RecipeToolsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeTools,
      getReferencedColumn: (t) => t.toolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeToolsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeTools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ToolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ToolsTable,
          Tool,
          $$ToolsTableFilterComposer,
          $$ToolsTableOrderingComposer,
          $$ToolsTableAnnotationComposer,
          $$ToolsTableCreateCompanionBuilder,
          $$ToolsTableUpdateCompanionBuilder,
          (Tool, $$ToolsTableReferences),
          Tool,
          PrefetchHooks Function({bool recipeStepsRefs, bool recipeToolsRefs})
        > {
  $$ToolsTableTableManager(_$AppDatabase db, $ToolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ToolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ToolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ToolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => ToolsCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => ToolsCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ToolsTable, Tool>(table),
                  $$ToolsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({recipeStepsRefs = false, recipeToolsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeStepsRefs) db.recipeSteps,
                    if (recipeToolsRefs) db.recipeTools,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeStepsRefs)
                        await $_getPrefetchedData<
                          Tool,
                          $ToolsTable,
                          RecipeStep
                        >(
                          currentTable: table,
                          referencedTable: $$ToolsTableReferences
                              ._recipeStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ToolsTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.toolId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recipeToolsRefs)
                        await $_getPrefetchedData<
                          Tool,
                          $ToolsTable,
                          RecipeTool
                        >(
                          currentTable: table,
                          referencedTable: $$ToolsTableReferences
                              ._recipeToolsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ToolsTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeToolsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.toolId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ToolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ToolsTable,
      Tool,
      $$ToolsTableFilterComposer,
      $$ToolsTableOrderingComposer,
      $$ToolsTableAnnotationComposer,
      $$ToolsTableCreateCompanionBuilder,
      $$ToolsTableUpdateCompanionBuilder,
      (Tool, $$ToolsTableReferences),
      Tool,
      PrefetchHooks Function({bool recipeStepsRefs, bool recipeToolsRefs})
    >;
typedef $$RecipesTableCreateCompanionBuilder = RecipesCompanion Function({
  Value<int> id,
  required String name,
  required RecipeKind kind,
  Value<double> expectedYieldFactor,
  Value<String?> notes,
  Value<DateTime> createdAt,
});
typedef $$RecipesTableUpdateCompanionBuilder = RecipesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<RecipeKind> kind,
  Value<double> expectedYieldFactor,
  Value<String?> notes,
  Value<DateTime> createdAt,
});

final class $$RecipesTableReferences
    extends BaseReferences<_$AppDatabase, $RecipesTable, Recipe> {
  $$RecipesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeIngredientsTable, List<RecipeIngredient>>
  _recipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recipeIngredients,
        aliasName: 'recipes__id__recipe_ingredients__recipe_id',
      );

  $$RecipeIngredientsTableProcessedTableManager get recipeIngredientsRefs {
    final manager = $$RecipeIngredientsTableTableManager(
      $_db,
      $_db.recipeIngredients,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecipeStepsTable, List<RecipeStep>>
  _recipeStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeSteps,
    aliasName: 'recipes__id__recipe_steps__recipe_id',
  );

  $$RecipeStepsTableProcessedTableManager get recipeStepsRefs {
    final manager = $$RecipeStepsTableTableManager(
      $_db,
      $_db.recipeSteps,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecipeToolsTable, List<RecipeTool>>
  _recipeToolsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeTools,
    aliasName: 'recipes__id__recipe_tools__recipe_id',
  );

  $$RecipeToolsTableProcessedTableManager get recipeToolsRefs {
    final manager = $$RecipeToolsTableTableManager(
      $_db,
      $_db.recipeTools,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeToolsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BatchItemsTable, List<BatchItem>>
  _batchItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.batchItems,
    aliasName: 'recipes__id__batch_items__recipe_id',
  );

  $$BatchItemsTableProcessedTableManager get batchItemsRefs {
    final manager = $$BatchItemsTableTableManager(
      $_db,
      $_db.batchItems,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_batchItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RecipeKind, RecipeKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get expectedYieldFactor => $composableBuilder(
    column: $table.expectedYieldFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeIngredientsRefs(
    Expression<bool> Function($$RecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredients,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recipeStepsRefs(
    Expression<bool> Function($$RecipeStepsTableFilterComposer f) f,
  ) {
    final $$RecipeStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableFilterComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recipeToolsRefs(
    Expression<bool> Function($$RecipeToolsTableFilterComposer f) f,
  ) {
    final $$RecipeToolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeTools,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeToolsTableFilterComposer(
            $db: $db,
            $table: $db.recipeTools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> batchItemsRefs(
    Expression<bool> Function($$BatchItemsTableFilterComposer f) f,
  ) {
    final $$BatchItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batchItems,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchItemsTableFilterComposer(
            $db: $db,
            $table: $db.batchItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedYieldFactor => $composableBuilder(
    column: $table.expectedYieldFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecipeKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get expectedYieldFactor => $composableBuilder(
    column: $table.expectedYieldFactor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> recipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recipeIngredients,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.recipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recipeStepsRefs<T extends Object>(
    Expression<T> Function($$RecipeStepsTableAnnotationComposer a) f,
  ) {
    final $$RecipeStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recipeToolsRefs<T extends Object>(
    Expression<T> Function($$RecipeToolsTableAnnotationComposer a) f,
  ) {
    final $$RecipeToolsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeTools,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeToolsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeTools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> batchItemsRefs<T extends Object>(
    Expression<T> Function($$BatchItemsTableAnnotationComposer a) f,
  ) {
    final $$BatchItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batchItems,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.batchItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, $$RecipesTableReferences),
          Recipe,
          PrefetchHooks Function({
            bool recipeIngredientsRefs,
            bool recipeStepsRefs,
            bool recipeToolsRefs,
            bool batchItemsRefs,
          })
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<RecipeKind> kind = const Value.absent(),
                Value<double> expectedYieldFactor = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                name: name,
                kind: kind,
                expectedYieldFactor: expectedYieldFactor,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required RecipeKind kind,
                Value<double> expectedYieldFactor = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RecipesCompanion.insert(
                id: id,
                name: name,
                kind: kind,
                expectedYieldFactor: expectedYieldFactor,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipesTable, Recipe>(table),
                  $$RecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                recipeIngredientsRefs = false,
                recipeStepsRefs = false,
                recipeToolsRefs = false,
                batchItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientsRefs) db.recipeIngredients,
                    if (recipeStepsRefs) db.recipeSteps,
                    if (recipeToolsRefs) db.recipeTools,
                    if (batchItemsRefs) db.batchItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeIngredientsRefs)
                        await $_getPrefetchedData<
                          Recipe,
                          $RecipesTable,
                          RecipeIngredient
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recipeStepsRefs)
                        await $_getPrefetchedData<
                          Recipe,
                          $RecipesTable,
                          RecipeStep
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recipeToolsRefs)
                        await $_getPrefetchedData<
                          Recipe,
                          $RecipesTable,
                          RecipeTool
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeToolsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeToolsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (batchItemsRefs)
                        await $_getPrefetchedData<
                          Recipe,
                          $RecipesTable,
                          BatchItem
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._batchItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).batchItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, $$RecipesTableReferences),
      Recipe,
      PrefetchHooks Function({
        bool recipeIngredientsRefs,
        bool recipeStepsRefs,
        bool recipeToolsRefs,
        bool batchItemsRefs,
      })
    >;
typedef $$RecipeIngredientsTableCreateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      required int recipeId,
      required int ingredientId,
      required double rawG,
      Value<int> rowid,
    });
typedef $$RecipeIngredientsTableUpdateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> recipeId,
      Value<int> ingredientId,
      Value<double> rawG,
      Value<int> rowid,
    });

final class $$RecipeIngredientsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredient
        > {
  $$RecipeIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_ingredients__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) => db
      .ingredients
      .createAlias('recipe_ingredients__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get rawG => $composableBuilder(
    column: $table.rawG,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get rawG => $composableBuilder(
    column: $table.rawG,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get rawG =>
      $composableBuilder(column: $table.rawG, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredient,
          $$RecipeIngredientsTableFilterComposer,
          $$RecipeIngredientsTableOrderingComposer,
          $$RecipeIngredientsTableAnnotationComposer,
          $$RecipeIngredientsTableCreateCompanionBuilder,
          $$RecipeIngredientsTableUpdateCompanionBuilder,
          (RecipeIngredient, $$RecipeIngredientsTableReferences),
          RecipeIngredient,
          PrefetchHooks Function({bool recipeId, bool ingredientId})
        > {
  $$RecipeIngredientsTableTableManager(
    _$AppDatabase db,
    $RecipeIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeIngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> recipeId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<double> rawG = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipeIngredientsCompanion(
                recipeId: recipeId,
                ingredientId: ingredientId,
                rawG: rawG,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int recipeId,
                required int ingredientId,
                required double rawG,
                Value<int> rowid = const Value.absent(),
              }) => RecipeIngredientsCompanion.insert(
                recipeId: recipeId,
                ingredientId: ingredientId,
                rawG: rawG,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeIngredientsTable, RecipeIngredient>(table),
                  $$RecipeIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false, ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeIngredientsTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeIngredientsTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (ingredientId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ingredientId,
                        referencedTable: $$RecipeIngredientsTableReferences
                            ._ingredientIdTable(db),
                        referencedColumn: $$RecipeIngredientsTableReferences
                            ._ingredientIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeIngredientsTable,
      RecipeIngredient,
      $$RecipeIngredientsTableFilterComposer,
      $$RecipeIngredientsTableOrderingComposer,
      $$RecipeIngredientsTableAnnotationComposer,
      $$RecipeIngredientsTableCreateCompanionBuilder,
      $$RecipeIngredientsTableUpdateCompanionBuilder,
      (RecipeIngredient, $$RecipeIngredientsTableReferences),
      RecipeIngredient,
      PrefetchHooks Function({bool recipeId, bool ingredientId})
    >;
typedef $$RecipeStepsTableCreateCompanionBuilder =
    RecipeStepsCompanion Function({
      Value<int> id,
      required int recipeId,
      required int position,
      required String technique,
      Value<int?> tempC,
      Value<int?> minutes,
      Value<int?> toolId,
    });
typedef $$RecipeStepsTableUpdateCompanionBuilder =
    RecipeStepsCompanion Function({
      Value<int> id,
      Value<int> recipeId,
      Value<int> position,
      Value<String> technique,
      Value<int?> tempC,
      Value<int?> minutes,
      Value<int?> toolId,
    });

final class $$RecipeStepsTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeStepsTable, RecipeStep> {
  $$RecipeStepsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_steps__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ToolsTable _toolIdTable(_$AppDatabase db) =>
      db.tools.createAlias('recipe_steps__tool_id__tools__id');

  $$ToolsTableProcessedTableManager? get toolId {
    final $_column = $_itemColumn<int>('tool_id');
    if ($_column == null) return null;
    final manager = $$ToolsTableTableManager(
      $_db,
      $_db.tools,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeStepsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technique => $composableBuilder(
    column: $table.technique,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableFilterComposer get toolId {
    final $$ToolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableFilterComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technique => $composableBuilder(
    column: $table.technique,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableOrderingComposer get toolId {
    final $$ToolsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableOrderingComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get technique =>
      $composableBuilder(column: $table.technique, builder: (column) => column);

  GeneratedColumn<int> get tempC =>
      $composableBuilder(column: $table.tempC, builder: (column) => column);

  GeneratedColumn<int> get minutes =>
      $composableBuilder(column: $table.minutes, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableAnnotationComposer get toolId {
    final $$ToolsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableAnnotationComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeStepsTable,
          RecipeStep,
          $$RecipeStepsTableFilterComposer,
          $$RecipeStepsTableOrderingComposer,
          $$RecipeStepsTableAnnotationComposer,
          $$RecipeStepsTableCreateCompanionBuilder,
          $$RecipeStepsTableUpdateCompanionBuilder,
          (RecipeStep, $$RecipeStepsTableReferences),
          RecipeStep,
          PrefetchHooks Function({bool recipeId, bool toolId})
        > {
  $$RecipeStepsTableTableManager(_$AppDatabase db, $RecipeStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> technique = const Value.absent(),
                Value<int?> tempC = const Value.absent(),
                Value<int?> minutes = const Value.absent(),
                Value<int?> toolId = const Value.absent(),
              }) => RecipeStepsCompanion(
                id: id,
                recipeId: recipeId,
                position: position,
                technique: technique,
                tempC: tempC,
                minutes: minutes,
                toolId: toolId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recipeId,
                required int position,
                required String technique,
                Value<int?> tempC = const Value.absent(),
                Value<int?> minutes = const Value.absent(),
                Value<int?> toolId = const Value.absent(),
              }) => RecipeStepsCompanion.insert(
                id: id,
                recipeId: recipeId,
                position: position,
                technique: technique,
                tempC: tempC,
                minutes: minutes,
                toolId: toolId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeStepsTable, RecipeStep>(table),
                  $$RecipeStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false, toolId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeStepsTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeStepsTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (toolId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.toolId,
                        referencedTable: $$RecipeStepsTableReferences
                            ._toolIdTable(db),
                        referencedColumn: $$RecipeStepsTableReferences
                            ._toolIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeStepsTable,
      RecipeStep,
      $$RecipeStepsTableFilterComposer,
      $$RecipeStepsTableOrderingComposer,
      $$RecipeStepsTableAnnotationComposer,
      $$RecipeStepsTableCreateCompanionBuilder,
      $$RecipeStepsTableUpdateCompanionBuilder,
      (RecipeStep, $$RecipeStepsTableReferences),
      RecipeStep,
      PrefetchHooks Function({bool recipeId, bool toolId})
    >;
typedef $$RecipeToolsTableCreateCompanionBuilder =
    RecipeToolsCompanion Function({
      required int recipeId,
      required int toolId,
      Value<int> rowid,
    });
typedef $$RecipeToolsTableUpdateCompanionBuilder =
    RecipeToolsCompanion Function({
      Value<int> recipeId,
      Value<int> toolId,
      Value<int> rowid,
    });

final class $$RecipeToolsTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeToolsTable, RecipeTool> {
  $$RecipeToolsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_tools__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ToolsTable _toolIdTable(_$AppDatabase db) =>
      db.tools.createAlias('recipe_tools__tool_id__tools__id');

  $$ToolsTableProcessedTableManager get toolId {
    final $_column = $_itemColumn<int>('tool_id')!;

    final manager = $$ToolsTableTableManager(
      $_db,
      $_db.tools,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeToolsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeToolsTable> {
  $$RecipeToolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableFilterComposer get toolId {
    final $$ToolsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableFilterComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeToolsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeToolsTable> {
  $$RecipeToolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableOrderingComposer get toolId {
    final $$ToolsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableOrderingComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeToolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeToolsTable> {
  $$RecipeToolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ToolsTableAnnotationComposer get toolId {
    final $$ToolsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toolId,
      referencedTable: $db.tools,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ToolsTableAnnotationComposer(
            $db: $db,
            $table: $db.tools,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeToolsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeToolsTable,
          RecipeTool,
          $$RecipeToolsTableFilterComposer,
          $$RecipeToolsTableOrderingComposer,
          $$RecipeToolsTableAnnotationComposer,
          $$RecipeToolsTableCreateCompanionBuilder,
          $$RecipeToolsTableUpdateCompanionBuilder,
          (RecipeTool, $$RecipeToolsTableReferences),
          RecipeTool,
          PrefetchHooks Function({bool recipeId, bool toolId})
        > {
  $$RecipeToolsTableTableManager(_$AppDatabase db, $RecipeToolsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeToolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeToolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeToolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> recipeId = const Value.absent(),
                Value<int> toolId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipeToolsCompanion(
                recipeId: recipeId,
                toolId: toolId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int recipeId,
                required int toolId,
                Value<int> rowid = const Value.absent(),
              }) => RecipeToolsCompanion.insert(
                recipeId: recipeId,
                toolId: toolId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeToolsTable, RecipeTool>(table),
                  $$RecipeToolsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false, toolId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$RecipeToolsTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$RecipeToolsTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (toolId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.toolId,
                        referencedTable: $$RecipeToolsTableReferences
                            ._toolIdTable(db),
                        referencedColumn: $$RecipeToolsTableReferences
                            ._toolIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeToolsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeToolsTable,
      RecipeTool,
      $$RecipeToolsTableFilterComposer,
      $$RecipeToolsTableOrderingComposer,
      $$RecipeToolsTableAnnotationComposer,
      $$RecipeToolsTableCreateCompanionBuilder,
      $$RecipeToolsTableUpdateCompanionBuilder,
      (RecipeTool, $$RecipeToolsTableReferences),
      RecipeTool,
      PrefetchHooks Function({bool recipeId, bool toolId})
    >;
typedef $$BatchSessionsTableCreateCompanionBuilder =
    BatchSessionsCompanion Function({
      Value<int> id,
      required DateTime cookedOn,
      required DateTime coversFrom,
      required DateTime coversTo,
    });
typedef $$BatchSessionsTableUpdateCompanionBuilder =
    BatchSessionsCompanion Function({
      Value<int> id,
      Value<DateTime> cookedOn,
      Value<DateTime> coversFrom,
      Value<DateTime> coversTo,
    });

final class $$BatchSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $BatchSessionsTable, BatchSession> {
  $$BatchSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$BatchItemsTable, List<BatchItem>>
  _batchItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.batchItems,
    aliasName: 'batch_sessions__id__batch_items__batch_session_id',
  );

  $$BatchItemsTableProcessedTableManager get batchItemsRefs {
    final manager = $$BatchItemsTableTableManager(
      $_db,
      $_db.batchItems,
    ).filter((f) => f.batchSessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_batchItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BatchSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $BatchSessionsTable> {
  $$BatchSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cookedOn => $composableBuilder(
    column: $table.cookedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get coversFrom => $composableBuilder(
    column: $table.coversFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get coversTo => $composableBuilder(
    column: $table.coversTo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> batchItemsRefs(
    Expression<bool> Function($$BatchItemsTableFilterComposer f) f,
  ) {
    final $$BatchItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batchItems,
      getReferencedColumn: (t) => t.batchSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchItemsTableFilterComposer(
            $db: $db,
            $table: $db.batchItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $BatchSessionsTable> {
  $$BatchSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cookedOn => $composableBuilder(
    column: $table.cookedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get coversFrom => $composableBuilder(
    column: $table.coversFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get coversTo => $composableBuilder(
    column: $table.coversTo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BatchSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatchSessionsTable> {
  $$BatchSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get cookedOn =>
      $composableBuilder(column: $table.cookedOn, builder: (column) => column);

  GeneratedColumn<DateTime> get coversFrom => $composableBuilder(
    column: $table.coversFrom,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get coversTo =>
      $composableBuilder(column: $table.coversTo, builder: (column) => column);

  Expression<T> batchItemsRefs<T extends Object>(
    Expression<T> Function($$BatchItemsTableAnnotationComposer a) f,
  ) {
    final $$BatchItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batchItems,
      getReferencedColumn: (t) => t.batchSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.batchItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatchSessionsTable,
          BatchSession,
          $$BatchSessionsTableFilterComposer,
          $$BatchSessionsTableOrderingComposer,
          $$BatchSessionsTableAnnotationComposer,
          $$BatchSessionsTableCreateCompanionBuilder,
          $$BatchSessionsTableUpdateCompanionBuilder,
          (BatchSession, $$BatchSessionsTableReferences),
          BatchSession,
          PrefetchHooks Function({bool batchItemsRefs})
        > {
  $$BatchSessionsTableTableManager(_$AppDatabase db, $BatchSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatchSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatchSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatchSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> cookedOn = const Value.absent(),
                Value<DateTime> coversFrom = const Value.absent(),
                Value<DateTime> coversTo = const Value.absent(),
              }) => BatchSessionsCompanion(
                id: id,
                cookedOn: cookedOn,
                coversFrom: coversFrom,
                coversTo: coversTo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime cookedOn,
                required DateTime coversFrom,
                required DateTime coversTo,
              }) => BatchSessionsCompanion.insert(
                id: id,
                cookedOn: cookedOn,
                coversFrom: coversFrom,
                coversTo: coversTo,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BatchSessionsTable, BatchSession>(table),
                  $$BatchSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (batchItemsRefs) db.batchItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (batchItemsRefs)
                    await $_getPrefetchedData<
                      BatchSession,
                      $BatchSessionsTable,
                      BatchItem
                    >(
                      currentTable: table,
                      referencedTable: $$BatchSessionsTableReferences
                          ._batchItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BatchSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).batchItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.batchSessionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BatchSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatchSessionsTable,
      BatchSession,
      $$BatchSessionsTableFilterComposer,
      $$BatchSessionsTableOrderingComposer,
      $$BatchSessionsTableAnnotationComposer,
      $$BatchSessionsTableCreateCompanionBuilder,
      $$BatchSessionsTableUpdateCompanionBuilder,
      (BatchSession, $$BatchSessionsTableReferences),
      BatchSession,
      PrefetchHooks Function({bool batchItemsRefs})
    >;
typedef $$BatchItemsTableCreateCompanionBuilder = BatchItemsCompanion Function({
  Value<int> id,
  required int batchSessionId,
  required int recipeId,
  required double rawTotalG,
  required double cookedTotalG,
});
typedef $$BatchItemsTableUpdateCompanionBuilder = BatchItemsCompanion Function({
  Value<int> id,
  Value<int> batchSessionId,
  Value<int> recipeId,
  Value<double> rawTotalG,
  Value<double> cookedTotalG,
});

final class $$BatchItemsTableReferences
    extends BaseReferences<_$AppDatabase, $BatchItemsTable, BatchItem> {
  $$BatchItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BatchSessionsTable _batchSessionIdTable(_$AppDatabase db) => db
      .batchSessions
      .createAlias('batch_items__batch_session_id__batch_sessions__id');

  $$BatchSessionsTableProcessedTableManager get batchSessionId {
    final $_column = $_itemColumn<int>('batch_session_id')!;

    final manager = $$BatchSessionsTableTableManager(
      $_db,
      $_db.batchSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('batch_items__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MealComponentsTable, List<MealComponent>>
  _mealComponentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealComponents,
    aliasName: 'batch_items__id__meal_components__batch_item_id',
  );

  $$MealComponentsTableProcessedTableManager get mealComponentsRefs {
    final manager = $$MealComponentsTableTableManager(
      $_db,
      $_db.mealComponents,
    ).filter((f) => f.batchItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealComponentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BatchItemsTableFilterComposer
    extends Composer<_$AppDatabase, $BatchItemsTable> {
  $$BatchItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rawTotalG => $composableBuilder(
    column: $table.rawTotalG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cookedTotalG => $composableBuilder(
    column: $table.cookedTotalG,
    builder: (column) => ColumnFilters(column),
  );

  $$BatchSessionsTableFilterComposer get batchSessionId {
    final $$BatchSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchSessionId,
      referencedTable: $db.batchSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchSessionsTableFilterComposer(
            $db: $db,
            $table: $db.batchSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> mealComponentsRefs(
    Expression<bool> Function($$MealComponentsTableFilterComposer f) f,
  ) {
    final $$MealComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealComponents,
      getReferencedColumn: (t) => t.batchItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealComponentsTableFilterComposer(
            $db: $db,
            $table: $db.mealComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $BatchItemsTable> {
  $$BatchItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rawTotalG => $composableBuilder(
    column: $table.rawTotalG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cookedTotalG => $composableBuilder(
    column: $table.cookedTotalG,
    builder: (column) => ColumnOrderings(column),
  );

  $$BatchSessionsTableOrderingComposer get batchSessionId {
    final $$BatchSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchSessionId,
      referencedTable: $db.batchSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.batchSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatchItemsTable> {
  $$BatchItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get rawTotalG =>
      $composableBuilder(column: $table.rawTotalG, builder: (column) => column);

  GeneratedColumn<double> get cookedTotalG => $composableBuilder(
    column: $table.cookedTotalG,
    builder: (column) => column,
  );

  $$BatchSessionsTableAnnotationComposer get batchSessionId {
    final $$BatchSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchSessionId,
      referencedTable: $db.batchSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.batchSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> mealComponentsRefs<T extends Object>(
    Expression<T> Function($$MealComponentsTableAnnotationComposer a) f,
  ) {
    final $$MealComponentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealComponents,
      getReferencedColumn: (t) => t.batchItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealComponentsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatchItemsTable,
          BatchItem,
          $$BatchItemsTableFilterComposer,
          $$BatchItemsTableOrderingComposer,
          $$BatchItemsTableAnnotationComposer,
          $$BatchItemsTableCreateCompanionBuilder,
          $$BatchItemsTableUpdateCompanionBuilder,
          (BatchItem, $$BatchItemsTableReferences),
          BatchItem,
          PrefetchHooks Function({
            bool batchSessionId,
            bool recipeId,
            bool mealComponentsRefs,
          })
        > {
  $$BatchItemsTableTableManager(_$AppDatabase db, $BatchItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatchItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatchItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatchItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> batchSessionId = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<double> rawTotalG = const Value.absent(),
                Value<double> cookedTotalG = const Value.absent(),
              }) => BatchItemsCompanion(
                id: id,
                batchSessionId: batchSessionId,
                recipeId: recipeId,
                rawTotalG: rawTotalG,
                cookedTotalG: cookedTotalG,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int batchSessionId,
                required int recipeId,
                required double rawTotalG,
                required double cookedTotalG,
              }) => BatchItemsCompanion.insert(
                id: id,
                batchSessionId: batchSessionId,
                recipeId: recipeId,
                rawTotalG: rawTotalG,
                cookedTotalG: cookedTotalG,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BatchItemsTable, BatchItem>(table),
                  $$BatchItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                batchSessionId = false,
                recipeId = false,
                mealComponentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mealComponentsRefs) db.mealComponents,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (batchSessionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.batchSessionId,
                            referencedTable: $$BatchItemsTableReferences
                                ._batchSessionIdTable(db),
                            referencedColumn: $$BatchItemsTableReferences
                                ._batchSessionIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (recipeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.recipeId,
                            referencedTable: $$BatchItemsTableReferences
                                ._recipeIdTable(db),
                            referencedColumn: $$BatchItemsTableReferences
                                ._recipeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mealComponentsRefs)
                        await $_getPrefetchedData<
                          BatchItem,
                          $BatchItemsTable,
                          MealComponent
                        >(
                          currentTable: table,
                          referencedTable: $$BatchItemsTableReferences
                              ._mealComponentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).mealComponentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.batchItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BatchItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatchItemsTable,
      BatchItem,
      $$BatchItemsTableFilterComposer,
      $$BatchItemsTableOrderingComposer,
      $$BatchItemsTableAnnotationComposer,
      $$BatchItemsTableCreateCompanionBuilder,
      $$BatchItemsTableUpdateCompanionBuilder,
      (BatchItem, $$BatchItemsTableReferences),
      BatchItem,
      PrefetchHooks Function({
        bool batchSessionId,
        bool recipeId,
        bool mealComponentsRefs,
      })
    >;
typedef $$MealLogsTableCreateCompanionBuilder = MealLogsCompanion Function({
  Value<int> id,
  required DateTime date,
  required int slot,
  required DayType dayType,
});
typedef $$MealLogsTableUpdateCompanionBuilder = MealLogsCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> slot,
  Value<DayType> dayType,
});

final class $$MealLogsTableReferences
    extends BaseReferences<_$AppDatabase, $MealLogsTable, MealLog> {
  $$MealLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MealComponentsTable, List<MealComponent>>
  _mealComponentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mealComponents,
    aliasName: 'meal_logs__id__meal_components__meal_log_id',
  );

  $$MealComponentsTableProcessedTableManager get mealComponentsRefs {
    final manager = $$MealComponentsTableTableManager(
      $_db,
      $_db.mealComponents,
    ).filter((f) => f.mealLogId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealComponentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DayType, DayType, String> get dayType =>
      $composableBuilder(
        column: $table.dayType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  Expression<bool> mealComponentsRefs(
    Expression<bool> Function($$MealComponentsTableFilterComposer f) f,
  ) {
    final $$MealComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealComponents,
      getReferencedColumn: (t) => t.mealLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealComponentsTableFilterComposer(
            $db: $db,
            $table: $db.mealComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dayType => $composableBuilder(
    column: $table.dayType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealLogsTable> {
  $$MealLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DayType, String> get dayType =>
      $composableBuilder(column: $table.dayType, builder: (column) => column);

  Expression<T> mealComponentsRefs<T extends Object>(
    Expression<T> Function($$MealComponentsTableAnnotationComposer a) f,
  ) {
    final $$MealComponentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealComponents,
      getReferencedColumn: (t) => t.mealLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealComponentsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealLogsTable,
          MealLog,
          $$MealLogsTableFilterComposer,
          $$MealLogsTableOrderingComposer,
          $$MealLogsTableAnnotationComposer,
          $$MealLogsTableCreateCompanionBuilder,
          $$MealLogsTableUpdateCompanionBuilder,
          (MealLog, $$MealLogsTableReferences),
          MealLog,
          PrefetchHooks Function({bool mealComponentsRefs})
        > {
  $$MealLogsTableTableManager(_$AppDatabase db, $MealLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<DayType> dayType = const Value.absent(),
              }) => MealLogsCompanion(
                id: id,
                date: date,
                slot: slot,
                dayType: dayType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required int slot,
                required DayType dayType,
              }) => MealLogsCompanion.insert(
                id: id,
                date: date,
                slot: slot,
                dayType: dayType,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealLogsTable, MealLog>(table),
                  $$MealLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealComponentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mealComponentsRefs) db.mealComponents,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealComponentsRefs)
                    await $_getPrefetchedData<
                      MealLog,
                      $MealLogsTable,
                      MealComponent
                    >(
                      currentTable: table,
                      referencedTable: $$MealLogsTableReferences
                          ._mealComponentsRefsTable(db),
                      managerFromTypedResult: (p0) => $$MealLogsTableReferences(
                        db,
                        table,
                        p0,
                      ).mealComponentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.mealLogId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealLogsTable,
      MealLog,
      $$MealLogsTableFilterComposer,
      $$MealLogsTableOrderingComposer,
      $$MealLogsTableAnnotationComposer,
      $$MealLogsTableCreateCompanionBuilder,
      $$MealLogsTableUpdateCompanionBuilder,
      (MealLog, $$MealLogsTableReferences),
      MealLog,
      PrefetchHooks Function({bool mealComponentsRefs})
    >;
typedef $$MealComponentsTableCreateCompanionBuilder =
    MealComponentsCompanion Function({
      Value<int> id,
      required int mealLogId,
      Value<int?> batchItemId,
      Value<int?> ingredientId,
      required double grams,
    });
typedef $$MealComponentsTableUpdateCompanionBuilder =
    MealComponentsCompanion Function({
      Value<int> id,
      Value<int> mealLogId,
      Value<int?> batchItemId,
      Value<int?> ingredientId,
      Value<double> grams,
    });

final class $$MealComponentsTableReferences
    extends BaseReferences<_$AppDatabase, $MealComponentsTable, MealComponent> {
  $$MealComponentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MealLogsTable _mealLogIdTable(_$AppDatabase db) =>
      db.mealLogs.createAlias('meal_components__meal_log_id__meal_logs__id');

  $$MealLogsTableProcessedTableManager get mealLogId {
    final $_column = $_itemColumn<int>('meal_log_id')!;

    final manager = $$MealLogsTableTableManager(
      $_db,
      $_db.mealLogs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealLogIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BatchItemsTable _batchItemIdTable(_$AppDatabase db) => db.batchItems
      .createAlias('meal_components__batch_item_id__batch_items__id');

  $$BatchItemsTableProcessedTableManager? get batchItemId {
    final $_column = $_itemColumn<int>('batch_item_id');
    if ($_column == null) return null;
    final manager = $$BatchItemsTableTableManager(
      $_db,
      $_db.batchItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) => db
      .ingredients
      .createAlias('meal_components__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager? get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id');
    if ($_column == null) return null;
    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealComponentsTableFilterComposer
    extends Composer<_$AppDatabase, $MealComponentsTable> {
  $$MealComponentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnFilters(column),
  );

  $$MealLogsTableFilterComposer get mealLogId {
    final $$MealLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealLogId,
      referencedTable: $db.mealLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealLogsTableFilterComposer(
            $db: $db,
            $table: $db.mealLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchItemsTableFilterComposer get batchItemId {
    final $$BatchItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchItemId,
      referencedTable: $db.batchItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchItemsTableFilterComposer(
            $db: $db,
            $table: $db.batchItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealComponentsTableOrderingComposer
    extends Composer<_$AppDatabase, $MealComponentsTable> {
  $$MealComponentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grams => $composableBuilder(
    column: $table.grams,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealLogsTableOrderingComposer get mealLogId {
    final $$MealLogsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealLogId,
      referencedTable: $db.mealLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealLogsTableOrderingComposer(
            $db: $db,
            $table: $db.mealLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchItemsTableOrderingComposer get batchItemId {
    final $$BatchItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchItemId,
      referencedTable: $db.batchItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchItemsTableOrderingComposer(
            $db: $db,
            $table: $db.batchItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealComponentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealComponentsTable> {
  $$MealComponentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get grams =>
      $composableBuilder(column: $table.grams, builder: (column) => column);

  $$MealLogsTableAnnotationComposer get mealLogId {
    final $$MealLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealLogId,
      referencedTable: $db.mealLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.mealLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchItemsTableAnnotationComposer get batchItemId {
    final $$BatchItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchItemId,
      referencedTable: $db.batchItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BatchItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.batchItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealComponentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealComponentsTable,
          MealComponent,
          $$MealComponentsTableFilterComposer,
          $$MealComponentsTableOrderingComposer,
          $$MealComponentsTableAnnotationComposer,
          $$MealComponentsTableCreateCompanionBuilder,
          $$MealComponentsTableUpdateCompanionBuilder,
          (MealComponent, $$MealComponentsTableReferences),
          MealComponent,
          PrefetchHooks Function({
            bool mealLogId,
            bool batchItemId,
            bool ingredientId,
          })
        > {
  $$MealComponentsTableTableManager(
    _$AppDatabase db,
    $MealComponentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealComponentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealComponentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealComponentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> mealLogId = const Value.absent(),
                Value<int?> batchItemId = const Value.absent(),
                Value<int?> ingredientId = const Value.absent(),
                Value<double> grams = const Value.absent(),
              }) => MealComponentsCompanion(
                id: id,
                mealLogId: mealLogId,
                batchItemId: batchItemId,
                ingredientId: ingredientId,
                grams: grams,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int mealLogId,
                Value<int?> batchItemId = const Value.absent(),
                Value<int?> ingredientId = const Value.absent(),
                required double grams,
              }) => MealComponentsCompanion.insert(
                id: id,
                mealLogId: mealLogId,
                batchItemId: batchItemId,
                ingredientId: ingredientId,
                grams: grams,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MealComponentsTable, MealComponent>(table),
                  $$MealComponentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mealLogId = false, batchItemId = false, ingredientId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mealLogId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.mealLogId,
                            referencedTable: $$MealComponentsTableReferences
                                ._mealLogIdTable(db),
                            referencedColumn: $$MealComponentsTableReferences
                                ._mealLogIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (batchItemId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.batchItemId,
                            referencedTable: $$MealComponentsTableReferences
                                ._batchItemIdTable(db),
                            referencedColumn: $$MealComponentsTableReferences
                                ._batchItemIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (ingredientId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ingredientId,
                            referencedTable: $$MealComponentsTableReferences
                                ._ingredientIdTable(db),
                            referencedColumn: $$MealComponentsTableReferences
                                ._ingredientIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MealComponentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealComponentsTable,
      MealComponent,
      $$MealComponentsTableFilterComposer,
      $$MealComponentsTableOrderingComposer,
      $$MealComponentsTableAnnotationComposer,
      $$MealComponentsTableCreateCompanionBuilder,
      $$MealComponentsTableUpdateCompanionBuilder,
      (MealComponent, $$MealComponentsTableReferences),
      MealComponent,
      PrefetchHooks Function({
        bool mealLogId,
        bool batchItemId,
        bool ingredientId,
      })
    >;
typedef $$HydrationLogsTableCreateCompanionBuilder =
    HydrationLogsCompanion Function({
      Value<int> id,
      required DateTime date,
      required int ml,
      Value<DateTime> loggedAt,
    });
typedef $$HydrationLogsTableUpdateCompanionBuilder =
    HydrationLogsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> ml,
      Value<DateTime> loggedAt,
    });

class $$HydrationLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HydrationLogsTable> {
  $$HydrationLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ml => $composableBuilder(
    column: $table.ml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HydrationLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HydrationLogsTable> {
  $$HydrationLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ml => $composableBuilder(
    column: $table.ml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HydrationLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HydrationLogsTable> {
  $$HydrationLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get ml =>
      $composableBuilder(column: $table.ml, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);
}

class $$HydrationLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HydrationLogsTable,
          HydrationLog,
          $$HydrationLogsTableFilterComposer,
          $$HydrationLogsTableOrderingComposer,
          $$HydrationLogsTableAnnotationComposer,
          $$HydrationLogsTableCreateCompanionBuilder,
          $$HydrationLogsTableUpdateCompanionBuilder,
          (
            HydrationLog,
            BaseReferences<_$AppDatabase, $HydrationLogsTable, HydrationLog>,
          ),
          HydrationLog,
          PrefetchHooks Function()
        > {
  $$HydrationLogsTableTableManager(_$AppDatabase db, $HydrationLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HydrationLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HydrationLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HydrationLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> ml = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => HydrationLogsCompanion(
                id: id,
                date: date,
                ml: ml,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required int ml,
                Value<DateTime> loggedAt = const Value.absent(),
              }) => HydrationLogsCompanion.insert(
                id: id,
                date: date,
                ml: ml,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HydrationLogsTable, HydrationLog>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $HydrationLogsTable,
                    HydrationLog
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HydrationLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HydrationLogsTable,
      HydrationLog,
      $$HydrationLogsTableFilterComposer,
      $$HydrationLogsTableOrderingComposer,
      $$HydrationLogsTableAnnotationComposer,
      $$HydrationLogsTableCreateCompanionBuilder,
      $$HydrationLogsTableUpdateCompanionBuilder,
      (
        HydrationLog,
        BaseReferences<_$AppDatabase, $HydrationLogsTable, HydrationLog>,
      ),
      HydrationLog,
      PrefetchHooks Function()
    >;
typedef $$DayLogsTableCreateCompanionBuilder = DayLogsCompanion Function({
  required DateTime date,
  Value<int> fruitPortions,
  Value<int> vegPortions,
  Value<int> rowid,
});
typedef $$DayLogsTableUpdateCompanionBuilder = DayLogsCompanion Function({
  Value<DateTime> date,
  Value<int> fruitPortions,
  Value<int> vegPortions,
  Value<int> rowid,
});

class $$DayLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DayLogsTable> {
  $$DayLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fruitPortions => $composableBuilder(
    column: $table.fruitPortions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vegPortions => $composableBuilder(
    column: $table.vegPortions,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DayLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DayLogsTable> {
  $$DayLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fruitPortions => $composableBuilder(
    column: $table.fruitPortions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vegPortions => $composableBuilder(
    column: $table.vegPortions,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DayLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayLogsTable> {
  $$DayLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get fruitPortions => $composableBuilder(
    column: $table.fruitPortions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vegPortions => $composableBuilder(
    column: $table.vegPortions,
    builder: (column) => column,
  );
}

class $$DayLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayLogsTable,
          DayLog,
          $$DayLogsTableFilterComposer,
          $$DayLogsTableOrderingComposer,
          $$DayLogsTableAnnotationComposer,
          $$DayLogsTableCreateCompanionBuilder,
          $$DayLogsTableUpdateCompanionBuilder,
          (DayLog, BaseReferences<_$AppDatabase, $DayLogsTable, DayLog>),
          DayLog,
          PrefetchHooks Function()
        > {
  $$DayLogsTableTableManager(_$AppDatabase db, $DayLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> date = const Value.absent(),
                Value<int> fruitPortions = const Value.absent(),
                Value<int> vegPortions = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayLogsCompanion(
                date: date,
                fruitPortions: fruitPortions,
                vegPortions: vegPortions,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required DateTime date,
                Value<int> fruitPortions = const Value.absent(),
                Value<int> vegPortions = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayLogsCompanion.insert(
                date: date,
                fruitPortions: fruitPortions,
                vegPortions: vegPortions,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DayLogsTable, DayLog>(table),
                  BaseReferences<_$AppDatabase, $DayLogsTable, DayLog>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DayLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayLogsTable,
      DayLog,
      $$DayLogsTableFilterComposer,
      $$DayLogsTableOrderingComposer,
      $$DayLogsTableAnnotationComposer,
      $$DayLogsTableCreateCompanionBuilder,
      $$DayLogsTableUpdateCompanionBuilder,
      (DayLog, BaseReferences<_$AppDatabase, $DayLogsTable, DayLog>),
      DayLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$DayTypeTargetRowsTableTableManager get dayTypeTargetRows =>
      $$DayTypeTargetRowsTableTableManager(_db, _db.dayTypeTargetRows);
  $$WeekScheduleEntriesTableTableManager get weekScheduleEntries =>
      $$WeekScheduleEntriesTableTableManager(_db, _db.weekScheduleEntries);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db, _db.ingredients);
  $$ToolsTableTableManager get tools =>
      $$ToolsTableTableManager(_db, _db.tools);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(_db, _db.recipeIngredients);
  $$RecipeStepsTableTableManager get recipeSteps =>
      $$RecipeStepsTableTableManager(_db, _db.recipeSteps);
  $$RecipeToolsTableTableManager get recipeTools =>
      $$RecipeToolsTableTableManager(_db, _db.recipeTools);
  $$BatchSessionsTableTableManager get batchSessions =>
      $$BatchSessionsTableTableManager(_db, _db.batchSessions);
  $$BatchItemsTableTableManager get batchItems =>
      $$BatchItemsTableTableManager(_db, _db.batchItems);
  $$MealLogsTableTableManager get mealLogs =>
      $$MealLogsTableTableManager(_db, _db.mealLogs);
  $$MealComponentsTableTableManager get mealComponents =>
      $$MealComponentsTableTableManager(_db, _db.mealComponents);
  $$HydrationLogsTableTableManager get hydrationLogs =>
      $$HydrationLogsTableTableManager(_db, _db.hydrationLogs);
  $$DayLogsTableTableManager get dayLogs =>
      $$DayLogsTableTableManager(_db, _db.dayLogs);
}
