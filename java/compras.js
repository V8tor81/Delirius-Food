
        // Função para atualizar o resumo da compra
        function updateSummary() {
            let subtotal = 0;
            document.querySelectorAll('.cart-item').forEach(item => {
                const price = parseFloat(item.querySelector('.price').innerText.replace('R$ ', '').replace(',', '.'));
                const quantity = parseInt(item.querySelector('.qty').innerText);
                subtotal += price * quantity; // Calcula o subtotal
            });
         
            // Atualiza o subtotal
            document.getElementById('subtotal').innerText = `R$ ${subtotal.toFixed(2).replace('.', ',')}`;
           
            // Condição para o frete
            const frete = subtotal < 20 && subtotal !== 0 ? 35 : 0; // Frete de R$ 35 se subtotal for menor que R$ 20 e diferente de 0
            document.getElementById('frete').innerText = `R$ ${frete.toFixed(2).replace('.', ',')}`;

            // Total
            const total = subtotal + frete; // Total
            document.getElementById('total').innerText = `R$ ${total.toFixed(2).replace('.', ',')}`;
        }

        // Função para obter os parâmetros da URL
        function getQueryParams() {
            const params = new URLSearchParams(window.location.search);
            const produto = params.get('produto');
            const preco = params.get('preco');
            return { produto, preco };
        }

        // Função para salvar o carrinho no localStorage
        function saveCart() {
            const cartItems = [];
            document.querySelectorAll('.cart-item').forEach(item => {
                const produto = item.querySelector('p').innerText;
                const price = item.querySelector('.price').innerText.replace('R$ ', '').replace(',', '.');
                const qty = item.querySelector('.qty').innerText;
                cartItems.push({ produto, price, qty });
            });
            localStorage.setItem('cart', JSON.stringify(cartItems));
        }

        // Função para carregar o carrinho do localStorage
        function loadCart() {
            const cartItems = JSON.parse(localStorage.getItem('cart')) || [];
            cartItems.forEach(item => {
                addItemToCart(item.produto, item.price, item.qty);
            });
        }

        // Função para adicionar item ao carrinho
        function addItemToCart(produto, preco, qty = 1) {
            const cartItemsDiv = document.getElementById('cart-items');
            const itemDiv = document.createElement('div');
            itemDiv.classList.add('cart-item');
            itemDiv.innerHTML = `
                <p>${produto}</p>
                <span class="price">R$ ${parseFloat(preco).toFixed(2).replace('.', ',')}</span>
                <div class="quantity">
                    <button class="decrease">-</button>
                    <span class="qty">${qty}</span>
                    <button class="increase">+</button>
                </div>
                <p class="total">Total: <span class="total-price">R$ ${parseFloat(preco * qty).toFixed(2).replace('.', ',')}</span></p>
                <button class="remove">&times;</button>
            `;
            cartItemsDiv.appendChild(itemDiv);

            // Atualiza o resumo da compra
            updateSummary();

            // Adiciona eventos para aumentar e diminuir a quantidade
            itemDiv.querySelector('.increase').addEventListener('click', () => {
                let qty = parseInt(itemDiv.querySelector('.qty').innerText);
                qty++;
                itemDiv.querySelector('.qty').innerText = qty;
                const totalPrice = parseFloat(preco) * qty;
                itemDiv.querySelector('.total-price').innerText = `R$ ${totalPrice.toFixed(2).replace('.', ',')}`;
                updateSummary(); // Atualiza o resumo após a alteração
                saveCart(); // Salva o carrinho
            });

            itemDiv.querySelector('.decrease').addEventListener('click', () => {
                let qty = parseInt(itemDiv.querySelector('.qty').innerText);
                if (qty > 1) {
                    qty--;
                    itemDiv.querySelector('.qty').innerText = qty;
                    const totalPrice = parseFloat(preco) * qty;
                    itemDiv.querySelector('.total-price').innerText = `R$ ${totalPrice.toFixed(2).replace('.', ',')}`;
                    updateSummary(); // Atualiza o resumo após a alteração
                    saveCart(); // Salva o carrinho
                }
            });

            // Remover o item
            itemDiv.querySelector('.remove').addEventListener('click', () => {
                itemDiv.remove();
                updateSummary(); // Atualiza o resumo após a remoção
                saveCart(); // Salva o carrinho
            });
        }

        document.addEventListener('DOMContentLoaded', () => {
            loadCart(); // Carrega o carrinho ao iniciar

            const { produto, preco } = getQueryParams();
            if (produto && preco) {
                addItemToCart(produto, preco); // Adiciona o item ao carrinho
            }
        });

        // Atualiza o resumo ao carregar a página
        updateSummary();