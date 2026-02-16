<template>
  <div class="burger-page">

    <h1 class="title">{{ burger.name }}</h1>
    <p class="weight">Вес: ~350–400 г</p>
    <p class="base">Основа: {{ burger.base }}</p>

    <div class="content">
      <img class="burger-img" :src="burger.image" />

      <div class="text-block">
        
        <h2 class="sub-title">Описание</h2>
        <p class="description">{{ burger.longDescription }}</p>

        <h2 class="sub-title">Особенности</h2>
        <ul class="list">
          <li v-for="(f, i) in burger.features" :key="i">
            ✓ {{ f }}
          </li>
        </ul>

        <h2 class="sub-title">Пищевая ценность (на 1 бургер):</h2>
        <ul class="nutrition">
          <li>🔥 Калории: {{ burger.calories }}</li>
          <li>🥩 Белки: {{ burger.protein }}</li>
          <li>🧈 Жиры: {{ burger.fat }}</li>
          <li>🌾 Углеводы: {{ burger.carbs }}</li>
        </ul>

        <div class="storage">
          <p>Условия хранения</p>
          <p>Срок годности: 24 часа  •  Температура: +3°C…+6°C</p>
        </div>

        <button class="order-btn">Оформить Заказ</button>

      </div>
    </div>

  </div>
</template>

<script>
export default {
  props: ['id'],

  data() {
    return {
      burgers: {
        1: {
          id: 1,
          name: "Чеддер КИНГ",
          base: "Сочная говяжья котлета",
          image: "/assets/images/Chedder1.png",
          longDescription:
            "«Чеддер Кинг» — это истинная классика в мире сыра и сочного мяса. Главный герой — толстая, ароматная говяжья котлета, идеально прожаренная до сочности. Два слоя плавленого сыра чеддер окутывают мясо, создавая насыщенный, тягучий и яркий вкус. Свежий салат, спелые томаты, хрустящий лук и мягкая пшеничная булочка завершают композицию. Фирменный сырный соус делает вкус ещё более глубоким и сливочным.",
          features: [
            "Двойной сыр чеддер",
            "Собственная говяжья котлета",
            "Свежие овощи",
            "Фирменный соус",
            "Готовится только после заказа"
          ],
          calories: "650–800 ккал",
          protein: "30–40 г",
          fat: "35–50 г",
          carbs: "40–55 г"
        },

        2: {
          id: 2,
          name: "Острый Техас",
          base: "Острая говяжья котлета",
          image: "/assets/images/Texas1.png",
          longDescription:
            "Острый Техас — пикантный бургер с фирменным острым соусом, хрустящим перцем халапеньо, сочной говяжьей котлетой и ароматным BBQ. Свежий лук, томаты и хрустящие листья салата дополняют насыщенный техасский вкус.",
          features: [
            "Острая говяжья котлета",
            "Перец халапеньо",
            "BBQ соус",
            "Хрустящие овощи",
            "Приготовление при заказе"
          ],
          calories: "600–780 ккал",
          protein: "28–38 г",
          fat: "30–48 г",
          carbs: "42–58 г"
        }
      }
    }
  },

  computed: {
    burger() {
      return this.burgers[this.id]
    }
  }
}
</script>

<style scoped>
.burger-page {
  width: 100%;
  max-width: 1550px;
  margin: 0 auto;
  padding-top: 40px;
  color: white;
  font-family: Arial, sans-serif;
}

.title {
  text-align: center;
  font-size: 58px;
  font-weight: 800;
}

.weight,
.base {
  text-align: center;
  font-size: 30px;
  margin-top: 5px;
}

.content {
  display: flex;
  margin-top: 40px;
  gap: 40px;
}

.burger-img {
  width: 700px;
  height: 800px;
  border-radius: 10px;
}

.text-block {
  max-width: 800px;
}

.sub-title {
  font-size: 34px;
  margin: 20px 0 10px;
  font-weight: 700;
}

.description {
  line-height: 1.45;
  font-size: 20px;
}

.list li,
.nutrition li {
  margin-bottom: 6px;
  font-size: 25px;
}

.storage{
    font-size: 20px;
}

.order-btn {
  margin-top: 25px;
  background: #ff2d2d;
  padding: 12px 20px;
  border: none;
  border-radius: 8px;
  font-size: 25px;
  cursor: pointer;
  color: white;
}
</style>
